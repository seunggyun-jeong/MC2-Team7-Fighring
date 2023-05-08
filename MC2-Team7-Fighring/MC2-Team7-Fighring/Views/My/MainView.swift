//
//  MainView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    TabView{
                        ForEach((1...6), id:\.self){ idx in
                            CouponView(days: (idx*6 - 5...6*idx))
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
