//
//  ContentView.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .my
    
    enum Tab {
        case my
        case lover
        case result
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MainView()
                .tabItem {
                    Label("My", systemImage: "person.circle.fill")
                }
                .tag(Tab.my)
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
