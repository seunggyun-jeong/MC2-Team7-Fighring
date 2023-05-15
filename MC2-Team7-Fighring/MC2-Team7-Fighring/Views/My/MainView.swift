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
                    setupAppearance()
                    moveTab()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
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
