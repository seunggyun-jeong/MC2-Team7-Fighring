//
//  MainView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var questions: FetchedResults<Question>
    
    @State private var selectedTab = 1
    @State private var tabs = [1, 2, 3, 4, 5, 6]
    
    var body: some View {
        
        
        NavigationStack {
            HStack {
                Text("36 Days")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.theme.secondary)
                Spacer()
            }
            .padding(.top, 18)
            .padding(.leading, 24)
            .padding(.bottom, 36)
            
            VStack{
                ZStack{
                    TabView (selection: $selectedTab){
                        ForEach(tabs, id:\.self){ idx in
                            VStack{

                                CouponView(questions: questions[idx*6-6...6*idx-1], startIdx: idx*6-6)
                            }
                        }
                        
                    }
                    
                    .padding(.top, 0)
                    .tabViewStyle(PageTabViewStyle())
                }
                .onAppear{
                    if UserDefaults.standard.bool(forKey: "setForUT") == true{
                        // do nothing
                    }else{
                        settingUT(questions: questions)
                        UserDefaults.standard.set(true, forKey: "setForUT")
                    }
                    setupAppearance()
                    moveTab()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func settingUT(questions: FetchedResults<Question> ){
        let UTnumbers = (0...29)
        for ut in UTnumbers{
            DataController().answerQuestion(question: questions[ut], questionAnswer: Int32(3), questionNum: questions[ut].questionNum, userReason: "Random", userEmotion: 0, context: managedObjectContext)
        }
    }
    
    func moveTab() {
        var currentWeek = 1
        let numbers = (0...35)
        for number in numbers{
            if questions[number].isSolved == true{
                if Int(questions[number].questionNum) % 6 == 0{
                    currentWeek = Int(questions[number].questionNum) / 6
                } else {
                    currentWeek = Int(questions[number].questionNum) / 6 + 1
                }
            }
        }
        selectedTab = currentWeek
        print(selectedTab)
    }
    
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
