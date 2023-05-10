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
    @State private var completeSix: Bool = true
    @State private var shareActivated: Bool = false
    @State private var count: Int = 0
    
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Button {
                    print("넘어가기")
                    if completeSix{
                        shareActivated = true
                    }else{
                        shareActivated = false
                    }
                    
                    
                } label: {
                    Text(completeSix ? "공유하기" : "\(count)/6")
                }
                .sheet(isPresented: $shareActivated, content: {
                    LetterView()
                })
                .disabled(!completeSix)
                .padding()
            }
            
            LazyVGrid(columns: columns) {
                ForEach(questions, id: \.self) { question in
                    NavigationLink(destination: EmotionSelectView(questionData: question)) {
                        VStack {
                            let image = Image(question.isSolved ? "greenMain" : "whiteMain")
                                .frame(width: 150, height: 150)
                                .padding(.zero)
                            
                            if question.isOpened {
                                image
                            } else {
                                image.blur(radius: 6)
                            }
                            
                            Text("Day \(question.questionNum)")
                                .foregroundColor(.black)
                                .padding(.zero)
                        }
                    }
                    .onTapGesture {
                        if question.isOpened {
                            // navigate to EmotionSelectView
                            isLock = false
                        } else {
                            isLock = true
                        }
                    }
                    .zIndex(isLock ? 1 : 0)
                   
                    }
//                      .disabled(!question.isOpened)
                    
                }
            .sheet(isPresented: $isLock) {
                LockView()
                
            }
            .onAppear{
                count = countSolved(questions: questions)
            }
            //            .navigationBarTitleDisplayMode(.inline)
            
            
            
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
