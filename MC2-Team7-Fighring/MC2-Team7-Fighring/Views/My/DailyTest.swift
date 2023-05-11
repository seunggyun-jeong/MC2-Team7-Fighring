//
//  DailyTest.swift
//  MC2-Team7-Fighring
//
//  Created by Ko Seokjun on 2023/05/08.
//

import SwiftUI

struct DailyTest: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    var questionData: FetchedResults<Question>.Element
    var userEmotion: Int
    
    @State var loverName: String = "❤️"
    @State var click = false
    @State var clicked = 0
    @State var reason: String = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Day \(Int(questionData.questionNum))")
                        .font(.title.bold())
                        .padding(.trailing, 5)
                
                    Image(EmotionStore().emotions[userEmotion])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45)
                    
                    Spacer()
                }
                
                HStack {
                    Text("\(QuestionList.question[Int(questionData.questionNum)-1])")
                        .font(.system(size: 22))
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
            .padding(.leading, 20)
            
            // Selection Answer View
            Group {
                HStack(spacing: 20){
                    ForEach(1 ..< 6){ index in
                        Button(action:{
                            click = true
                            clicked = index
                        }){
                            if index == clicked {
                                // 하트 마크
                                ZStack{
                                    Circle()
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(click ? Color(red: 255/255, green: 151/255, blue: 172/255): .white)
                                    
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 24))
                                }
                            }
                            else{
                                Circle()
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.white)
                                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
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
            
            
            // TextEditor - Why
            ZStack(alignment: .topLeading){
                TextEditor(text: $reason)
                    .font(.system(size: 18))
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.gray.opacity(0.15))
                    )
                    .padding(.horizontal, 30)
                    .lineLimit(4)
                
                if reason.isEmpty {
                    Text("이유에 대해 생각해보아요!\nex.델리빈 볼 말랑말랑")
                        .font(.system(size: 18))
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.leading, 36)
                        .padding(.top, 8)
                }
            }
            .frame(height: 130)
            .padding(.bottom, 40)
            
            
            // 저장하기 버튼 (Data Store - Question)
            Button {
                DataController().answerQuestion(question: questionData, questionAnswer: Int32(clicked), questionNum: questionData.questionNum, userReason: reason, userEmotion: Int32(userEmotion), context: managedObjectContext)
            } label: {
                Text("저장하기")
                    .foregroundColor(.white)
                    .font(.body.bold())
                    .padding(.horizontal, 150)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(reason.isEmpty || clicked == 0 ? .gray.opacity(0.5) : Color(red: 255/255, green: 151/255, blue: 172/255))
                    )
                    .font(.system(size: 17))
            }
            .disabled(reason.isEmpty || clicked == 0)
            .padding(.bottom, 40)
        }
        .onAppear {
            reason = questionData.userReason ?? ""
            
            if Int(questionData.questionAnswer) != 0 {
                clicked = Int(questionData.questionAnswer)
                click = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: LeadingBackBtnView(dismissDest: "나의 감정"))
    }
}


