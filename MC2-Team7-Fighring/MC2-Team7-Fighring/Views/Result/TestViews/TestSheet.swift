//
//  TestSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct TestSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var click = [Int](repeating: 0, count: 36)
    @State var clicked = [Int](repeating: 0, count: 36)
    @State var showResultSheet: Bool = false
    @State var attachmentType: AttachmentType = .anxious
    @State var anxiousScore: Double = 0.0
    @State var avoidantScore: Double = 0.0
    
    
    var body: some View {
        ScrollView{
            ForEach(0 ..< 36){ y in
                
                HStack {
                    Text("Q\(y+1). ")
                        .font(.system(size: 22))
                        .padding(.top, 10)
                        .frame(width: 45)
                        .frame(maxHeight: .infinity, alignment: .top)

                    Text(QuestionList.question[y])
                        .frame(width: 260, alignment: .leading)
                        .font(.system(size: 22))
                        .padding(.bottom, 20)
                        .padding(.trailing, 30)
                        .padding(.top, 10)
                        .multilineTextAlignment(.leading)
                    
                }
                .frame(width: .infinity, alignment: .topLeading)
                .padding(.leading, 20)
                
                HStack(spacing: 18){
                    ForEach(1 ..< 6){ index in
                        Button(action:{
                            click[y] = 1
                            clicked[y] = index
                            
                        }){
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(clicked[y] == index ? Color(red: 255/255, green: 151/255, blue: 172/255) : .white)
                                    .overlay(Circle().stroke(clicked[y] == index ? Color(red: 255/255, green: 151/255, blue: 172/255) : Color.gray.opacity(0.5), lineWidth: 1))
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 24))
                                    .opacity(clicked[y] == index ? 1 : 0)
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 5)
                
                HStack{
                    Text("전혀 그렇지 않다")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("매우 그렇다")
                        .foregroundColor(.gray)
                }
                .font(.caption)
                .padding(.leading, 30)
                .padding(.trailing, 40)
                .padding(.bottom, 20)
            }
            
            ButtonComponent(buttonStyle: .long, color: click.min() == 0 ? .theme.secondary : .accentColor) {
                "검사결과확인"
            } action: {
                showResultSheet.toggle()
            }
            .disabled(click.min() == 0 ? true : false)
        }
        .sheet(isPresented: $showResultSheet) {
            MyResultSheet(isGetResult: .constant(false), attachmentType: resultAlgorithm().0, avoidantScore: resultAlgorithm().2, anxiousScore: resultAlgorithm().1, isMyResult: false) {
                dismiss()
            }
        }
    }
    
    func resultAlgorithm() -> (AttachmentType, Double, Double) {
        var evenData: Int = 0
        var oddData: Int = 0
        
        for i in 0...35 {
            if i % 2 == 0 {
                evenData += clicked[i]
                print("----> \(i)의 값 \(clicked[i]) 짝수 값 \(evenData)")
            } else {
                oddData += clicked[i]
                print("----> \(i)의 값 \(clicked[i]) 홀수 값 \(oddData)")
            }
        }
        
        // 회피 점수 및 불안 점수 계산
        let avoidantScore: Double = Double(oddData) / 18
        let anxiousScore: Double = Double(evenData) / 18
        print("----> 불안점수 : \(anxiousScore)")
        print("----> 회피점수 : \(avoidantScore)")
        
        // 각 점수를 5점 만점 -> 100점 만점 환산 (score * 20)
        let exchangedAvoidantScore: Double = avoidantScore * 20
        let exchangedAnxiousScore: Double = anxiousScore * 20
        
        print("----> 환산된 불안점수 : \(exchangedAnxiousScore)")
        print("----> 환산된 회피점수 : \(exchangedAvoidantScore)")
        
        // 유형 검사
        if avoidantScore < 2.33 {
            if anxiousScore < 2.61 {
                // 안정형
                return (.secure, exchangedAnxiousScore, exchangedAvoidantScore)
            } else {
                // 불안형
                return (.anxious, exchangedAnxiousScore, exchangedAvoidantScore)
            }
        } else {
            if anxiousScore < 2.61 {
                // 회피형
                return (.avoidant, exchangedAnxiousScore, exchangedAvoidantScore)
            } else {
                // 공포형
                return (.fearful, exchangedAnxiousScore, exchangedAvoidantScore)
            }
        }
    }
}

struct TestSheet_Previews: PreviewProvider {
    static var previews: some View {
        TestSheet()
    }
}
