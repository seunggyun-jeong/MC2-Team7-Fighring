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
                    TabView{
                        ForEach((1...6), id:\.self){ idx in
                            VStack{
<<<<<<< Updated upstream
                                CouponView(questions: questions[idx*6-6...6*idx-1])
                                    .tabItem {
                                        Image(systemName: "\(idx).circle")
                                    }
=======
                                CouponView(questions: questions[idx*6-6...6*idx-1], startIdx: idx*6-6)
>>>>>>> Stashed changes
                            }
                        }
                    }
                    .padding(.top, 0)
                    .tabViewStyle(PageTabViewStyle())
                }
                .onAppear{
                    setupAppearance()
                    checkAllComplete(question: questions[35])
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    

    
    func checkAllComplete(question: FetchedResults<Question>.Element){
        if question.isSolved == true{
            UserDefaults.standard.set(true, forKey: "isAllComplete")
        }
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
