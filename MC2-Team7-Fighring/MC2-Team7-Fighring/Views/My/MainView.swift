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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var share: FetchedResults<Sharing>
    
    
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
                    checkOpened(questions: questions)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func checkOpened(questions: FetchedResults<Question>){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let endDate = dateFormatter.date(from: DataController().getCurrentDateTime()) ?? Date()
        
        let numbers = (0...34)
        let points = [6, 12, 18, 24, 30]
        
        for number in numbers{
            if questions[number].openedDate != "none"{
                let targetDate = dateFormatter.date(from: questions[number].openedDate!) ?? Date()
                let interval = endDate.timeIntervalSince(targetDate)
                let days = Int(interval / 86400)
                print("\(days) 일 차이 난다")
                
                if points.contains(number) {
                    let cnt = share.count
                    
                    if points.contains(cnt){
                        questions[number].isOpened = true
                    }
                }
                else{
                    if(days == 1){
                        questions[number+1].isOpened = true
                        print(questions[number+1].questionNum)
                    }
                }
            }
        }
    }
    
    func checkAllComplete(questions: FetchedResults<Question>){
        if questions[35].isSolved == true{
            
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
