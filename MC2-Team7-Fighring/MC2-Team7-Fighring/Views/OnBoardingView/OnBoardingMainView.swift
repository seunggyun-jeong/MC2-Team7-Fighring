//
//  OnBoardingMain.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/08.
//

import SwiftUI

struct OnBoardingMainView: View {
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        // OnBoarding 탭 리스트.
        TabView {
            OnBoardingView1(isFirstLaunch: $isFirstLaunch)
            OnBoardingView2(isFirstLaunch: $isFirstLaunch)
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            setupAppearance()
        }
    }
    
    // 탭바 인디케이터 커스터마이징 함수
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}


// 온보드 상단 건너뛰기 창 Extract View
struct OnboardingTopView: View {
    @State private var showToggle: Bool = false
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                showToggle.toggle()
            } label: {
                Text("건너뛰기")
                    .foregroundColor(.black)
            }
            .sheet(isPresented: $showToggle) {
                OnBoardingNameView(isFirstLaunch: $isFirstLaunch)
            }
        }
        .padding(.trailing, 15)
    }
}

