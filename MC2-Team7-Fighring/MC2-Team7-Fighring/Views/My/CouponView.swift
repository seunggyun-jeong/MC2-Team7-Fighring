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
                            NavigationLink(destination: EmotionSelectView(questionData: question)) {
                                
                                Image(question.isSolved ? "solvedFlower" : "opendFlower")
                                    .frame(width: 120, height: 110)
                                    .padding(.zero)
                                
                                
                                
                            }
                        }else{
                            // if question is closed
                            Button {
                                isLock = !question.isOpened
                            } label: {
                                
                                Image("closedFlower")
                                    .frame(width: 120, height: 110)
                                    .padding(.zero)
                                
                            }
                        }
                        // 몇일째의 질문인지 표기
                        Text("Day \(question.questionNum)")
                            //.foregroundColor(Color("AccentColor"))
                            .padding(.bottom)
                    }
                }
            }
            Button {
                if completeSix{
                    shareActivated = true
                }else{
                    shareActivated = false
                }
            } label: {
                Text(completeSix ? "공유하기" : "\(count)/6")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 130)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(completeSix ? Color("AccentColor") : .theme.secondary)
                    )
            }
            .sheet(isPresented: $shareActivated, content: {
                LetterView(questions: questions)
            })
            .disabled(!completeSix)
            .padding()
            .onAppear{
                count = countSolved(questions: questions)
                if count == 6{
                    completeSix = true
                } else{
                    completeSix = false
                }
            }
            .sheet(isPresented: $isLock, content: {
                LockView()
            })
        }
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
