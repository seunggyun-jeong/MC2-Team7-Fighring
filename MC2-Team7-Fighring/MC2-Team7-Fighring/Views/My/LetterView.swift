//
//  LetterView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//

import SwiftUI

struct LetterView: View {
    
    @State private var letters: String = ""
    
    //@State private var chars: [Character]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            VStack{
                Group {
                    Text("상대방이 볼 수 있는 6글자를 입력해주세요.")
                    Text("*입력시 수정 불가 :)")
                }.padding(.bottom)
                
                
                TextField("예) 너가너무좋아", text: $letters)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 200, height: 50)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .onChange(of: letters) { newValue in
                        if letters.count >= 6 {
                            letters = String(letters.prefix(6))
                        }
                    }
                
                Button {
                    let _ = print(letters)
                    dismiss()
                } label: {
                    Text("저장하기")
                        .foregroundColor(letters.count == 6 ? .blue : .gray)
                }
                .disabled(letters.count != 6)
                .padding()

            }
            
            
        }
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView()
    }
}
