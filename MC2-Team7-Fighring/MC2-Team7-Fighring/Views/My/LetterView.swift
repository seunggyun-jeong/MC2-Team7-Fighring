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
    var questions: FetchedResults<Question>.SubSequence
    var startIdx: Int
   //  @State private var letters: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: LetterField?
    @State private var showModal: Bool = false
    @State private var finalCode: String = ""
    @State private var input: String = ""
   
    
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
                
                
                TextField("6글자를 입력해주세요.", text: $input)
                    .onChange(of: input) { newText in
                               if newText.count > 6 {
                                   input = String(newText.prefix(6))
                               }
                           }
                           .underlineTextField()
                           .padding(.horizontal, 100)
//                LetterField()
//                    .onChange(of: letters) { newValue in
//                        letterCondition(value: newValue)
//                    }
//                    .onAppear {
//                        focusedField = .f1
//                    }
                
            
                Button {
                    showModal.toggle()
                   // finalCode = letters.joined()
                } label: {
                    Text("코드 공유하기")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(input.count != 6 ? .gray : Color("AccentColor"))
                        )
                }
                .disabled(input.count != 6)
                .sheet(isPresented: $showModal) {
                    // TODO: Deep Link 지정 후 수정 예정  1 -> 1, 7 -> 2, 13 -> 3
                    ActivityViewController(activityItems: ["lover36://receive?message=\(getStringData(startIdx: startIdx))\(input)"])
                        .onDisappear {
                            dismiss()
                        }
                }
            }
        }
    }
    
//    @ViewBuilder
//    func LetterField() -> some View {
//        HStack(spacing:15) {
//            ForEach(0..<6, id: \.self) { idx in
//                VStack(spacing: 8) {
//                    TextField("", text: $input[idx])
//                        .multilineTextAlignment(.center)
//                        .focused($focusedField, equals: activeStateForIndex(index: idx))
//
//                    Rectangle()
//                        .fill(focusedField == activeStateForIndex(index: idx) ? .blue : .gray.opacity(0.3))
//                        .frame(height: 4)
//                }
//                .frame(width: 40)
//            }
//        }
//    }
//
//    // 코드 입력 Validation 확인
//    func checkBtnStatus() -> Bool {
//        for i in 0..<6 {
//            if letters[i].isEmpty {
//                return true
//            }
//        }
//        return false
//    }
//
//    func letterCondition(value: [String])  {
//        // 한 글자 입력되면 다음 칸으로 이동하기.
//        for i in 0..<5 {
//            if value[i].count > 1 && activeStateForIndex(index: i) == focusedField {
//                focusedField = activeStateForIndex(index: i + 1)
//            }
//        }
//
//        // 뒤로가기
//        for i in 1...5 {
//            if value[i].isEmpty && !value[i - 1].isEmpty {
//                focusedField = activeStateForIndex(index: i - 1)
//            }
//        }
//
//
//        // 한 글자 이상 입력되는 경우 마지막 한 글자만 받는다.
//        for i in 0..<6 {
//            if value[i].count == 2 {
//                letters[i] = String(value[i].last!)
//            }
//        }
//    }
//
//    func activeStateForIndex(index: Int) -> LetterField {
//        switch index {
//        case 0: return .f1
//        case 1: return .f2
//        case 2: return .f3
//        case 3: return .f4
//        case 4: return .f5
//        default: return .f6
//        }
//    }
    
    // url로 넘길 데이터 string (주차 + 해당 주차의 답변)
    func getStringData(startIdx: Int) -> String {
        var week: String = ""
        var answer: String = ""
        
        
        week = String((questions[startIdx].questionNum / 6) + 1)   // 몇 주차인지 확인
        
        for i in startIdx..<startIdx+6 {
            answer.append(String(questions[i].questionAnswer))  // 해당 주차 내부의 문제 답변
        }
        
        week.append(answer)
        
        return week
    }
}


//struct LetterView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetterView()
//    }
//}


extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Color("AccentColor"))
            .padding(10)
    }
}
