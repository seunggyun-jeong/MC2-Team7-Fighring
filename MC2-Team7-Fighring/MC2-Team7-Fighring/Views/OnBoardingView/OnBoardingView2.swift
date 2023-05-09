//
//  OnBoardingView2.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/08.
//

import SwiftUI

struct OnBoardingView2: View {
    @State private var showNameToggle: Bool = false
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        ZStack {
            Color(red: 216/255, green: 216/255, blue: 216/255).edgesIgnoringSafeArea(.all)
            VStack {
                OnboardingTopView(isFirstLaunch: $isFirstLaunch)
                
                Spacer()
                
                Text("Onboarding 2")
                
                Spacer()
                
                Button {
                    showNameToggle.toggle()
                } label: {
                    Text("시작하기")
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color(red: 151/255, green: 151/255, blue: 151/255).opacity(0.4), lineWidth: 0.5)
                        )
                }
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $showNameToggle) {
                OnBoardingNameView(isFirstLaunch: $isFirstLaunch)
            }
            
        }
    }
}
