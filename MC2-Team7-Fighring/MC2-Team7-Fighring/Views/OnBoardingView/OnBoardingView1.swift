//
//  OnBoardingView1.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/08.
//

import SwiftUI

struct OnBoardingView1: View {
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        ZStack {
            Color(red: 216/255, green: 216/255, blue: 216/255).edgesIgnoringSafeArea(.all)
            VStack {
                OnboardingTopView(isFirstLaunch: $isFirstLaunch)
                
                Spacer()

                Text("Onboarding 1")
                
                Spacer()
            }
        }
    }
}
