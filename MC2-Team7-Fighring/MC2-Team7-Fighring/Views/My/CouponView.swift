//
//  CouponView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//
import SwiftUI

struct CouponView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    var questions: FetchedResults<Question>.SubSequence
    @State private var isLock: Bool = false
    @State private var isNavigation: Bool = false
    @State private var completeSix: Bool = false
    @State private var notCompleteSix: Bool = false
    @State private var shareActivated: Bool = false
    @State private var count: Int = 0
    
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View {
        VStack{
            LazyVGrid(columns: columns) {
                ForEach(questions, id: \.self) { question in
                    
                    VStack{
                        // if question is opened
                        if question.isOpened{
                            
                            if question.isSolved{
                                NavigationLink(destination: DailyTest(questionData: question, userEmotion: Int(question.userEmotion))) {
                                    Image("solvedFlower")
                                        .frame(width: 120, height: 110)
                                        .padding(.zero)
                                }
                                
                            //not yet solved
                            }else{
                                NavigationLink(destination: EmotionSelectView(questionData: question)) {
                                    
                                    Image("opendFlower")
                                        .frame(width: 120, height: 110)
                                        .padding(.zero)
                                }
                            }
                        }else{
                            // if question is closed
                            Button {
                                isLock = !question.isOpened
                                if isLock == true{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        isLock = false
                                    }
                                }
                            } label: {
                                
                                Image("closedFlower")
                                    .frame(width: 120, height: 110)
                                    .padding(.zero)
                                
                            }
                        }
                        // 몇일째의 질문인지 표기
                        Text("Day \(question.questionNum)")
                            .foregroundColor(.theme.secondary)
                            .padding(.bottom)
                    }
                }
            }
            Button {
                shareActivated = completeSix
                notCompleteSix = !completeSix
            } label: {
                Text(completeSix ? "공유하기" : "\(count)/6")
                    .foregroundColor(.white)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 150)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(completeSix ? Color("AccentColor") : .theme.secondary)
                    )
            }
            Spacer()
        }
        .sheet(isPresented: $completeSix, content: {
            CompleteSixNotifyView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $notCompleteSix, content: {
            LockView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $shareActivated, content: {
            LetterView(questions: questions)
        })
        .padding()
        .onAppear{
            count = countSolved(questions: questions)
            if count == 6{
                completeSix = true
            } else{
                completeSix = false
            }
        }
        .overlay(isLock ? ToastView(text:"아직 열리지 않았어요") : nil)
        //toast로 변경
        //            .sheet(isPresented: $isLock, content: {
        //                LockView()
        //            })
        
    }
    
    func countSolved(questions: FetchedResults<Question>.SubSequence) -> Int{
        var count = 0
        for question in questions{
            if count == 6{
                count = 6
            }
            else if question.isSolved == true{
                count = count + 1
            }
        }
        return count
    }
}
