//
//  ContentView.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var question: FetchedResults<Question>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var share: FetchedResults<Sharing>
    
    
    
    @State private var selection: Tab = .my

    // 앱을 첫 실행할 때만 온보딩 화면 띄우기 위한 변수
    @AppStorage("_isFirstLaunch") var isFirst: Bool = true
    
    enum Tab {
        case my
        case lover
        case result
    }
    
    var body: some View {
        if isFirst {
            
            OnBoardingView0(isFirstLaunch: $isFirst)
                .edgesIgnoringSafeArea(.all)
            
        } else {
            TabView(selection: $selection) {
                MainView(questions: question)
                    .tabItem {
                        Label("My", systemImage: "person.circle.fill")
                    }
                    .tag(Tab.my)
                    // TODO: URL 데이터 처리
                    .onOpenURL { url in
//                        let urlStr = "lover36://receive?message=1123456널좋아한다구"
//                        print(encodedStr)
                        selection = .lover
                        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
                        if components.scheme == "lover36", components.host == "receive", let message = components.queryItems?.first(where: { $0.name == "message" })?.value {
                            let data = Array(message)
                            let week = 6*Int(String(data[0]))! - 7
                            if(week == -1 && share.count != 0 || week == 5 && share.count != 6 || week == 11 && share.count != 12 || week == 17 && share.count != 18 || week == 23 && share.count != 24 || week == 29 && share.count != 30){
                                print("error")
                                return
                            }
                            for n in 1...6{
//                                print( Int(String(n))! + week, data[Int(String(n))!], data[Int(String(n))! + 6])
                                let num = Int32(Int(String(n))! + week)
                                let answer = Int32(String(data[Int(String(n))!]))!
                                let letterC = String(data[Int(String(n))! + 6])
                                print(num, answer ,letterC )
//                                DataController().saveSharingData(questionNum: num, questionAnswer: answer, letter: letterC, context: managedObjectContext)
                            }
                        }
                        
                    }
                        
                
                LoverHome()
                    .tabItem {
                        Label("Lover", systemImage: "heart.circle")
                    }
                    .tag(Tab.lover)
                
                ResultHome()
                    .tabItem {
                        Label("Result", systemImage: "book.circle.fill")
                    }
                    .tag(Tab.result)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  //  @StateObject private var dataController = DataController()
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
