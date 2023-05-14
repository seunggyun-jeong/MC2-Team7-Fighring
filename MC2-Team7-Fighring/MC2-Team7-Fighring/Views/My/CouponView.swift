//
//  CouponView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//
import SwiftUI

struct CouponView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var share: FetchedResults<Sharing>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var questionFull: FetchedResults<Question>
    
    
    var questions: FetchedResults<Question>.SubSequence
    @State private var isLock: Bool = false
    @State private var isNavigation: Bool = false
    @State private var completeSix: Bool = false
    @State private var completeSixModal: Bool = false
    @State private var notCompleteSix: Bool = false
    @State private var shareActivated: Bool = false
    @State private var count: Int = 0
    
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View {
        VStack{
            Spacer()
            LazyVGrid(columns: columns) {
                ForEach(questions, id: \.self) { question in
                    
                    VStack{
                        
                        // if question is opened
                        if question.isOpened{
                            
                            if question.isSolved{
                                NavigationLink(destination: DailyTest(questionData: question, userEmotion: Int(question.userEmotion), hasDone: true)) {
                                    Image("solvedFlower")
                                        .frame(width: 120, height: 110)
                                        .padding(.zero)
                                }
                                
                                //not yet solved
                            } else {
                                NavigationLink(destination: EmotionSelectView(questionData: question, hasDone: false)) {
                                    Image("opendFlower")
                                        .frame(width: 120, height: 110)
                                        .padding(.zero)
                                }
                            }
                        } else {
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
                print("share \(shareActivated), sixComplete \(completeSix)")
            } label: {
                Text(completeSix ? "공유하기" : "\(count)/6")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(completeSix ? Color("AccentColor") : .theme.secondary)
                    )
            }
            Spacer()
        }
        // when button is pressed
        .sheet(isPresented: $shareActivated, content: {
            LetterView(questions: questions)
            
        })
        // when six questions are done => notification => 라빈얼굴
        .sheet(isPresented: $completeSixModal, content: {
            CompleteSixNotifyView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        // when not completed => 규니얼굴
        .sheet(isPresented: $notCompleteSix, content: {
            LockView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        
        .onAppear{
            checkOpened(questions: questions)
            count = countSolved(questions: questions)
            if count == 6{
                completeSix = true
                completeSixModal = true
                if UserDefaults.standard.bool(forKey: "completeSixModal") == true{
                    completeSixModal = false
                }
                UserDefaults.standard.set(true, forKey: "completeSixModal")
            }
            
        }
        .overlay(isLock ? ToastView(text:"아직 열리지 않았어요") : nil)
        
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
    
    func checkOpened(questions: FetchedResults<Question>.SubSequence){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let endDate = dateFormatter.date(from: DataController().getCurrentDateTime()) ?? Date()
        
        let targetDate = dateFormatter.date(from: questions[questions.startIndex].openedDate!) ?? Date()
        let interval = endDate.timeIntervalSince(targetDate)
        let days = Int(interval / 86400)
        //    print("\(days) 일 차이 난다")
        
        let points = [6, 12, 18, 24, 30]
        
        for index in (1...5){
            if(days >= index){
                questions[questions.startIndex + index].isOpened = true
                questions[questions.startIndex + index].openedDate = DataController().getCurrentDateTime()
                if index == 5{
                    let cnt = share.count
                    if points.contains(cnt){
                        questionFull[questions.startIndex + cnt].openedDate = DataController().getCurrentDateTime()
                        questionFull[questions.startIndex + cnt].isOpened = true
                    }
                }
            }
        }
    }
}
