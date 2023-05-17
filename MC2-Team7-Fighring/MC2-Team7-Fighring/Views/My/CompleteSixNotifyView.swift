//
//  CompleteSixNotifyView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/13.
//

import SwiftUI

struct CompleteSixNotifyView: View {
    @Environment(\.presentationMode) var presentationMode
    var idx:Int
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.theme.secondary)
                    }
                }
                .padding([.top, .bottom], 24)
                
                Text("\(idx)일차 질문이 완료되었어요!")
                    .fontWeight(.heavy)
                    .font(.system(size: 25))
                    .padding(.bottom, 16)
                
                Text("상대방에게 공유해 보아요 ♡")
                    .font(.callout)
                    .bold()
            }
            Image("Lavine")
                .resizable()
                .scaledToFit()
                .frame(height: 206)
                .padding(.top, 36)
            
            Spacer()
            
            Text("아래의 화면 아래 버튼에서 나의 답변을 상대방에게 공유해보세요 :)")
                .multilineTextAlignment(.center)
                .font(.callout)
                .bold()
            
            Spacer()
        }
        .padding(.horizontal, 18)
    }
}
