//
//  OnboardingContents.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/10.
//

import SwiftUI

struct OnboardingContents: View {
    var title: String
    var image: String
    var description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
            
            VStack {
                Text(title)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 18)
                    .padding(.top, 36)
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 347)
                    .padding(.bottom, 30)
                
                Text(description)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 21))
                
                Spacer()
            }
        }

    }
}

struct OnboardingContents_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContents(title: "왜 36일인가요?", image: "imageName", description: "존 볼비의 애착 이론을 기반으로, 36일동안 애착 유형을 검사할 수 있는 앱입니다.")
    }
}
