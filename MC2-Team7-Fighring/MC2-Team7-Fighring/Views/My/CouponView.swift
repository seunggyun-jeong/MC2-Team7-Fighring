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
    @State private var completeSix: Bool = false
    @State private var shareActivated: Bool = false
    @State private var count: Int = 0
    
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View {
        
        VStack{
            
            LazyVGrid(columns: columns) {
                ForEach(questions, id: \.self) { question in
                    
                    
                    NavigationLink(destination: EmotionSelectView(questionData: question)) {
                        VStack {
                            let image = Image(question.isSolved ? "greenMain" : "whiteMain")
                                .frame(width: 120, height: 110)
                                .padding(.zero)
                            
                            if question.isOpened {
                                image
                            } else {
                                image
                            }
                            
                            Text("Day \(question.questionNum)")
                                .foregroundColor(.black)
                                .padding(.zero)
                        }
                    }
                    
                    .onAppear{
                        count = countSolved(questions: questions)
                        if count == 6{
                            completeSix = true
                        } else{
                            completeSix = false
                        }
                        checkDate(question: questions)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        
                        isLock = !question.isOpened
                        //isLock.toggle()
                        print(isLock)
                    })
                   // .disabled(!question.isOpened)
                    
                    
                    .sheet(isPresented: $isLock, content: {
                        LockView()
                    })
                    
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
                            .foregroundColor(completeSix ? Color("ThemeColor") : .gray)
                    )
                
                
            }
            .sheet(isPresented: $shareActivated, content: {
                LetterView()
            })
            .disabled(!completeSix)
            .padding()
            
        }
        .sheet(isPresented: $isLock) {
            LockView()
                .onAppear{
                    count = countSolved(questions: questions)
                    
                }
        }
        //        .navigationBarTitleDisplayMode(.inline)
        
        
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
    
    
    
    func checkDate(question: FetchedResults<Question>.SubSequence){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let endDate = dateFormatter.date(from: DataController().getCurrentDateTime()) ?? Date()
        
        let numbers = (0...5)
        
        for number in numbers{
            if 0 < number && number > 5{
                let targetDate = dateFormatter.date(from: question[number-1].clearDate!) ?? Date()
                let interval = endDate.timeIntervalSince(targetDate)
                let days = Int(interval / 86400)
                print("\(days) 일 차이 난다")
                if(days == 1){
                    question[number].isOpened = true
                }
            }
        }
    }
}
