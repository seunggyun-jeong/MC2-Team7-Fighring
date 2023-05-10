//
//  OnBoardingMain.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/08.
//

import SwiftUI

struct OnBoardingMainView: View {
    @Binding var isFirstLaunch: Bool
    @State var selection: Int = 0
    
    let lastPage: Int = 2
    var body: some View {
        VStack {
            OnboardingTopView(isFirstLaunch: $isFirstLaunch)
                .padding(.bottom, 12)
            // OnBoarding 탭 리스트.
            TabView(selection: $selection) {
                OnboardingContents(title: "이 앱은 무슨 앱인가요?", image: "John_Bowlby", description: "존 볼비의 애착 이론을 기반으로, 36일동안 애착 유형을 검사할 수 있는 앱입니다.")
                    .tag(0)
                OnboardingContents(title: "이 앱은 무슨 앱인가요?", image: "John_Bowlby", description: "존 볼비의 애착 이론을 기반으로, 36일동안 애착 유형을 검사할 수 있는 앱입니다.")
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .padding(.horizontal, 18)
            .onAppear {
                setupAppearance()
            }
            
            Button {
                withAnimation {
                    selection += 1
                }
            } label: {
                Text("다음")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(color: Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)), radius: 8, x: 0, y: 3)
            }
            .padding(.horizontal, 12)
            .padding(.top, 36)
            
            Spacer()
        }
        .background(.cyan)
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
                    .fontWeight(.semibold)
                    .font(.system(size: 13))
                    .frame(width: 80, height: 28)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(7)
                    .shadow(color: Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)), radius: 8, x: 0, y: 3)
            }
            .sheet(isPresented: $showToggle) {
                OnBoardingNameView(isFirstLaunch: $isFirstLaunch)
            }
        }
        .padding(.trailing, 15)
    }
}

struct OnBoardingMainView_preview: PreviewProvider {
    static var previews: some View {
        OnBoardingMainView(isFirstLaunch: .constant(true))
    }
}

