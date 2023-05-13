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
            VStack{
                ZStack{
                    TabView{
                        ForEach((1...6), id:\.self){ idx in
                            VStack{
                                CouponView(questions: questions[idx*6-6...6*idx-1])
                                    .tabItem {
                                        Image(systemName: "\(idx).circle")
                                    }
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
                .navigationTitle("36 Days")
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
