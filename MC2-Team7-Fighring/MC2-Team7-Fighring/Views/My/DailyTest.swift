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
    
    @FocusState private var isReasonFocused: Bool
    @State var loverName: String = "❤️"
    @State var click = false
    @State var clicked = 0
    @State var reason: String = ""
    @State var isShowModal: Bool = false
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    var body: some View {
        
        VStack {
            Spacer()
            
            ScrollView {
                VStack(alignment: .leading) {
                    // 제목 및 감정
                    HStack(spacing: 0) {
                        Text("Day \(Int(questionData.questionNum))")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(.trailing, 13)
                        
                        Button {
                            isShowModal.toggle()
                        } label: {
                            Image(EmotionStore().emotions[userEmotion])
                                .resizable()
                                .scaledToFit()
                                .frame(height: 42)
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
                    .padding(.bottom, 42)
                // 질문
                Text("\(QuestionList.question[Int(questionData.questionNum)-1])")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(alignment: .leading)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 42)
            .padding(.bottom, 34)
            .padding(.horizontal, 26)
            
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
                                        .foregroundColor(click ? .accentColor : .white)
                                        .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 1))
                                    
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 24))
                                }
                            }
                            else{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                                    .overlay(Circle().stroke(Color("secondary"), lineWidth: 1))
                            }
                        }
                    }
                }
                .frame(height: 45)
                .padding(.horizontal, 40)
                .padding(.bottom, 5)
                
                // 답변 Placeholder
                HStack {
                    Text("전혀 그렇지 않다")
                    Spacer()
                    Text("매우 그렇다")
                }
                .foregroundColor(.theme.secondary)
                .font(.footnote.bold())
                .padding(.leading, 25)
                .padding(.trailing, 37)
                .padding(.bottom, 40)
            }
            
            
            // TextEditor - Why
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.theme.secondary.opacity(0.2))
                
                if reason.isEmpty {
                    VStack(alignment: .leading) {
                        Text("어떠한 이유로 위의 답변을 선택하게 되었나요?\n선택한 이유에 대해 간단히 적어보아요 :)")
                            .padding(.top, 18)
                            .padding(.trailing, 10)
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Spacer()
                    }
                    .onTapGesture {
                        isReasonFocused = true
                    }
                }
                
                TextEditor(text: $reason)
                    .font(.system(size: 18))
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    .onChange(of: reason) { newValue in
                        if newValue.count > 50 {
                            reason = String(newValue.prefix(50))
                        }
                    }
                    .focused($isReasonFocused)
            }.onAppear (perform : UIApplication.shared.hideKeyboard)
                .frame(height: 124)
                .padding(.bottom, 40)
            
            Spacer()
        }
            NavigationLink {
                MainView(questions: question)
            } label: {
                Text("저장하기")
                    .foregroundColor(.white)
                    .padding(.horizontal, 148)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(reason.isEmpty || clicked == 0 ? .theme.secondary : .accentColor)
                    )
                    .font(.system(size: 17))
            }
            .padding(.bottom, keyboardHandler.keyboardHeight == 0 ? 0 : keyboardHandler.keyboardHeight - 120)
            .animation(.easeInOut(duration: 0.25), value: keyboardHandler.keyboardHeight)
            .disabled(reason.isEmpty || clicked == 0)
            .simultaneousGesture(TapGesture().onEnded {
                // 저장하기
                DataController().answerQuestion(question: questionData, questionAnswer: Int32(clicked), questionNum: questionData.questionNum, userReason: reason, userEmotion: Int32(userEmotion), context: managedObjectContext)
            })
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 60)
        }
        .onAppear {
            reason = questionData.userReason ?? ""
            
            if Int(questionData.questionAnswer) != 0 {
                clicked = Int(questionData.questionAnswer)
                click = true
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarItems(leading: LeadingBackBtnView(dismissDest: hasDone ? "36 days" : "나의 감정"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbarBackground(Color.white, for: .navigationBar)
    }
}


