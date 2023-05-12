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
    @State var showNameToggle: Bool = false
    
    let lastPage: Int = 4
    var body: some View {
        VStack {
            OnboardingTopView(isFirstLaunch: $isFirstLaunch)
                .padding(.bottom, 12)
            
            // OnBoarding 탭 리스트.
            TabView(selection: $selection) {
                OnboardingContents(title: "이 앱은 무슨 앱인가요?", image: "John_Bowlby", description: "존 볼비의 애착 이론을 기반으로,\n 36일동안 애착 유형을\n검사할 수 있는 앱입니다.")
                    .tag(0)
                
                OnboardingContents(title: "왜 36일인가요?", image: "onBoarding2", description: "애착 유형을 검사하는 것 뿐만 아니라,질문에 대해 생각해보고,\n나의 행동을 돌아볼 수 있습니다!")
                    .tag(1)
                
                OnboardingContents(title: "왜 36일인가요?", image: "onBoarding4", description: "주어지는 질문에 답변하다 보면,\n6일마다 나의 애인에게 공유할 수 있습니다.")
                    .tag(2)

                OnboardingContents(title: "왜 36일인가요?", image: "onBoarding5", description: "공유 링크를 통해 연인의 결과지를 확인해볼 수 있어요.")
                    .tag(3)
                
                OnboardingContents(title: "왜 36일인가요?", image: "onBoarding6", description: "36일 후에 나의 유형에대한 결과를 확인할 수 있어요.")
                    .tag(4)

            }
            .tabViewStyle(PageTabViewStyle())
            .padding(.horizontal, 18)
            .onAppear {
                setupAppearance()
            }
            
            Button {
                withAnimation {
                    if selection == lastPage {
                        showNameToggle.toggle()
                    } else {
                        selection += 1
                    }
                }
            } label: {
                Text(selection == lastPage ? "완료" : "다음")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 12)
            
            Spacer()
        }
        .sheet(isPresented: $showNameToggle) {
            OnBoardingNameView(isFirstLaunch: $isFirstLaunch)
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
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
            Text("36 Days")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.theme.secondary)
            
            Spacer()
            
            Button("건너뛰기") {
                showToggle.toggle()
            }
            .fontWeight(.semibold)
            .sheet(isPresented: $showToggle) {
                OnBoardingNameView(isFirstLaunch: $isFirstLaunch)
                    .presentationDetents([.fraction(0.5)])
            }
        }
        .padding(.top, 18)
        .padding(.horizontal, 24)
    }
}

struct OnBoardingMainView_preview: PreviewProvider {
    static var previews: some View {
        OnBoardingMainView(isFirstLaunch: .constant(true))
    }
}

