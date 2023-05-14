//
//  DailyTest.swift
//  MC2-Team7-Fighring
//
//  Created by Ko Seokjun on 2023/05/08.
//

import SwiftUI

struct DailyTest: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var question: FetchedResults<Question>
    
    var questionData: FetchedResults<Question>.Element
    var userEmotion: Int
    var hasDone: Bool
    
    @State var loverName: String = "❤️"
    @State var click = false
    @State var clicked = 0
    @State var reason: String = ""
    @State var isShowModal: Bool = false
    
    
    var body: some View {
        VStack {
            VStack {
                // 제목 및 감정
                HStack {
                    Text("Day \(Int(questionData.questionNum))")
                        .font(.title.bold())
                        .padding(.trailing, 5)
                    
                    Button {
                        isShowModal.toggle()
                    } label: {
                        Image(EmotionStore().emotions[userEmotion])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 45)
                    }
                    .sheet(isPresented: $isShowModal) {
                        EmotionSelectView(questionData: questionData, hasDone: true)
                            .presentationDetents([.height(500)])
                            .padding(.top, 40)
                            .presentationDragIndicator(.visible)
                    }
                    .disabled(!hasDone)


                    Spacer()
                }
                
                // 질문
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
                // 답변
                HStack(spacing: 20) {
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
                                        .overlay(Circle().stroke(Color(red: 255/255, green: 151/255, blue: 172/255), lineWidth: 1))
                                    
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 24))
                                }
                            }
                            else{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 5)
                
                // 답변 Placeholder
                HStack {
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
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray.opacity(0.1))
                
                TextEditor(text: $reason)
                    .font(.system(size: 18))
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    // 글자 수 제한 - 50자
                    .onChange(of: reason) { newValue in
                        if newValue.count > 50 {
                            reason = String(newValue.prefix(50))
                        }
                        
                    }
                
                if reason.isEmpty {
                    VStack (alignment: .leading) {
                        Text("어떠한 이유로 위의 답변을 선택하게 되었나요?\n선택한 이유에 대해 간단히 적어보아요 :)")
                            .padding(.top, 18)
                            .padding(.trailing, 10)
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Spacer()
                    }
                }
            }
            .frame(height: 130)
            .padding(.bottom, 40)
            
            NavigationLink {
                MainView(questions: question)
            } label: {
                Text("저장하기")
                    .foregroundColor(.white)
                    .font(.body.bold())
                    .padding(.horizontal, 130)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(reason.isEmpty || clicked == 0 ? .gray.opacity(0.5) : Color(red: 255/255, green: 151/255, blue: 172/255))
                    )
                    .font(.system(size: 17))
            }
            .disabled(reason.isEmpty || clicked == 0)
            .padding(.bottom, 40)
            .simultaneousGesture(TapGesture().onEnded {
                // 저장하기
                DataController().answerQuestion(question: questionData, questionAnswer: Int32(clicked), questionNum: questionData.questionNum, userReason: reason, userEmotion: Int32(userEmotion), context: managedObjectContext)
            })
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            reason = questionData.userReason ?? ""
            
            if Int(questionData.questionAnswer) != 0 {
                clicked = Int(questionData.questionAnswer)
                click = true
            }
        }
        .navigationBarItems(leading: LeadingBackBtnView(dismissDest: hasDone ? "36 days" : "나의 감정"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
    
    // 빈 곳을 터치했을 때 키보드 내리기
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


