//
//  LockView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//

import SwiftUI

struct LockView: View {
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("아직 6일이 지나지 않았어요.\n")
                .bold()
                .font(.system(size: 25))
            Text("조금만 더 기다려 주세요 ♡\n6일 간의 질문이 끝나면 아래 버튼을 통해\n나의 답변을 상대방에게 공유할 수 있어요 :)")
            
            Image("Guynni")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .padding()
            
        }
        
        
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView()
    }
}
