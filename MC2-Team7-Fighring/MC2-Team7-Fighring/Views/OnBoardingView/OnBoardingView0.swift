//
//  OnBoardingView0.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/08.
//

import SwiftUI

struct OnBoardingView0: View {
    @State private var isNextViewPresented = false
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isNextViewPresented = true
                }
            VStack {
                Spacer()

                Text("앱 이름")
                    .font(.title.bold())
                
                Spacer()
                
                Text("화면을 터치해주세요")
                    .font(.caption2)
                    .foregroundColor(.gray)
            
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $isNextViewPresented) {
            OnBoardingMainView(isFirstLaunch: $isFirstLaunch)
        }
    }
}
