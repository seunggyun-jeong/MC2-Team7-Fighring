//
//  LockView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//

import SwiftUI

struct LockView: View {
    @Environment(\.presentationMode) var presentationMode
    var questions: FetchedResults<Question>.SubSequence
    
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
                
                Text("아직일이 지나지 않았어요!")
                    .fontWeight(.heavy)
                    .font(.system(size: 25))
                    .padding(.bottom, 16)
                
                Text("조금만 더 기다려 주세요 ♡")
                    .font(.callout)
                    .bold()
            }
            Image("Guynni")
                .resizable()
                .scaledToFit()
                .frame(height: 206)
                .padding(.top, 36)
            
            Spacer()
            
            Text("6일 간의 질문이 끝나면 아래 버튼에서 나의 답변을\n상대방에게 공유할 수 있어요 :)")
                .multilineTextAlignment(.center)
                .font(.callout)
                .bold()
            
            Spacer()
        }
        .padding(.horizontal, 18)
        
    }
}

//struct LockView_Previews: PreviewProvider {
//    static var previews: some View {
//        LockView()
//    }
//}
