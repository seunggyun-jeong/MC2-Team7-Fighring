//
//  CompleteSixNotifyView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/13.
//

import SwiftUI

struct CompleteSixNotifyView: View {
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("6일차 질문이 완료되었어요!\n")
                .bold()
                .font(.system(size: 25))
            Text("상대방에게 공유해 보아요 ♡\n'공유하기'버튼을 눌러 나의 답변을 상대방에게 공유해보세요 :)")
            
            Image("Lavine")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .padding()
            
        }
    }
}

struct CompleteSixNotifyView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSixNotifyView()
    }
}
