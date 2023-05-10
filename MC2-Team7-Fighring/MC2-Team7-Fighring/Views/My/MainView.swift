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
//                Button("Create"){
//                    DataController().addData(context: managedObjectContext)
//                }
//                Button("Reset"){
//                    DataController().resetCoreData(viewContext: managedObjectContext)
//                }
                ZStack{
                    TabView{
                        ForEach((1...6), id:\.self){ idx in
                            CouponView(questions: questions[idx*6-6...6*idx-1])
                                .tabItem {
                                    Image(systemName: "\(idx).circle")
                                }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
                .navigationTitle("My 0.0")
                .onAppear{
                    setupAppearance()
                }
                
            }
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
