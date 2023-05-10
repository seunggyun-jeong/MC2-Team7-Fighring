//
//  LetterView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//

import SwiftUI

// focusState Enum
enum LetterField{
    case f1
    case f2
    case f3
    case f4
    case f5
    case f6
}

struct LetterView: View {
    @State private var letters: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: LetterField?
    @State private var showModal: Bool = false
    @State private var finalCode: String = ""
    
    //@State private var chars: [Character]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            VStack{
                Group {
                    Text("상대방이 볼 수 있는\n6글자를 입력해주세요.")
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                    Text("*입력시 수정 불가 :)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }.padding(.bottom)
                
                
                LetterField()
                    .onChange(of: letters) { newValue in
                        letterCondition(value: newValue)
                    }
                    .onAppear {
                        focusedField = .f1
                    }
                
                
                Button {
                    showModal.toggle()
                    finalCode = letters.joined()
                    let _ = print(finalCode)
                } label: {
                    Text("코드 공유하기")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(checkBtnStatus() ? .gray : .blue)
                        )
                }
                .disabled(checkBtnStatus())
                .padding()
                .sheet(isPresented: $showModal) {
                    // TODO: Deep Link 지정 후 수정 예정
                    ActivityViewController(activityItems: ["lover36://\(letters.joined())"])
                }
            }
        }
        
    }
    
    @ViewBuilder
    func LetterField() -> some View {
        HStack(spacing:15) {
            ForEach(0..<6, id: \.self) { idx in
                VStack(spacing: 8) {
                    TextField("", text: $letters[idx])
                        .multilineTextAlignment(.center)
                        .focused($focusedField, equals: activeStateForIndex(index: idx))
                    
                    Rectangle()
                        .fill(focusedField == activeStateForIndex(index: idx) ? .blue : .gray.opacity(0.3))
                        .frame(height: 4)
                }
                .frame(width: 40)
            }
        }
    }
    
    // 코드 입력 Validation 확인
    func checkBtnStatus() -> Bool {
        for i in 0..<6 {
            if letters[i].isEmpty {
                return true
            }
        }
        return false
    }
    
    func letterCondition(value: [String])  {
        // 한 글자 입력되면 다음 칸으로 이동하기.
        for i in 0..<5 {
            if value[i].count == 1 && activeStateForIndex(index: i) == focusedField {
                focusedField = activeStateForIndex(index: i + 1)
            }
        }
        
        // 뒤로가기
        for i in 1...5 {
            if value[i].isEmpty && !value[i - 1].isEmpty {
                focusedField = activeStateForIndex(index: i - 1)
            }
        }
        
        
        // 한 글자 이상 입력되는 경우 마지막 한 글자만 받는다.
        for i in 0..<6 {
            if value[i].count > 1 {
                letters[i] = String(value[i].last!)
            }
        }
    }
    
    func activeStateForIndex(index: Int) -> LetterField {
        switch index {
        case 0: return .f1
        case 1: return .f2
        case 2: return .f3
        case 3: return .f4
        case 4: return .f5
        default: return .f6
        }
    }
}


struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView()
    }
}


