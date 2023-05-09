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
                ForEach(questions, id: \.self) {  question in
                    NavigationLink (destination: EmotionSelectView()){
                        Button {
                            question.isSolved.toggle()
                            isLock = question.isSolved
                            DataController().save(context: managedObjectContext)
                            count = countSolved(questions: questions)
                        }
                    label: {
                        VStack{
                            Image(question.isSolved ? "greenMain" : "whiteMain")
                                .frame(width: 150, height: 150)
                                .padding(.zero)
                            Text("Day \(question.questionNum)")
                                .foregroundColor(.black)
                                .padding(.zero)
                        }
                        
                    }
                    }
                }
//                .sheet(isPresented: $isLock){
//                    LockView()}
            }
            .onAppear{
                count = countSolved(questions: questions)
            }
            Divider()
                .frame(width: 200)
                .background(.black)
                .padding(.top)
            
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
            .disabled(!completeSix)

        }
        .sheet(isPresented: $shareActivated) {
            LetterView()
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

//struct CouponView_Previews: PreviewProvider {
//    static var previews: some View {
//        CouponView(quesdays: (1...6))
//    }
//}
