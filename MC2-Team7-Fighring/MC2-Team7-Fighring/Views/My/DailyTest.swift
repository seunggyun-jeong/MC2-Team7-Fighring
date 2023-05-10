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
        VStack(alignment: .center){
            Text("Day \(Int(questionData.questionNum))")
                .font(.system(size: 34))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 41, trailing: 0))
                .bold()
            
            Text("\(QuestionList.question[Int(questionData.questionNum)-1])")
                .font(.system(size: 25))
                .frame(alignment: .center)
                .padding()
            // .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
            
            HStack(spacing: 18){
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
                                    .foregroundColor(click ? .pink: .white)
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 24))
                            }
                        }
                        else{
                            Circle()
                                .frame(width: 45, height: 45)
                                .foregroundColor(.white)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack{
                HStack{
                    Text("전혀 그렇지 않다")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                    Spacer()
                    Text("매우 그렇다")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }
                .frame(width: 337)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 66, trailing: 0))
            
            ZStack(alignment: .topLeading){
                TextField("이유에 대해 생각해봐요!", text: $reason)
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .scrollContentBackground(.hidden)
                    .padding(EdgeInsets(top: 20, leading: 21, bottom: 0, trailing: 0))
                
            }
            .frame(width: 336, height: 124, alignment: .top)
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 69, trailing: 0))
            
            Button {
                DataController().answerQuestion(question: questionData, questionAnswer: Int32(clicked), questionNum: questionData.questionNum, userReason: reason, userEmotion: Int32(userEmotion), context: managedObjectContext)
                
                
            } label: {
                
                Text("저장하기")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(reason.isEmpty || clicked == 0 ? .gray : .blue)
                    )
                    .font(.system(size: 17))
                
                
            }.disabled(reason.isEmpty || clicked == 0)
            
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

//struct DailyTest_Previews: PreviewProvider {
//    @Environment(\.managedObjectContext) var managedObjectContext
//
//    var questions: FetchedResults<Question>.Element
//
//    static var previews: some View {
//        DailyTest(questionData: questions)
//    }
//}
