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
    var startIdx: Int
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
            LazyVGrid(columns: columns) {
                ForEach(questions, id: \.self) { question in
                    
                    VStack{
                        
                        // if question is opened
                        if question.isOpened{
                            
                            if question.isSolved{
                                NavigationLink(destination: DailyTest(questionData: question, userEmotion: Int(question.userEmotion), hasDone: true)) {
                                    Image("solvedFlower")
                                        .resizable()
                                        .frame(width: 100, height: 90)
                                        .padding(.zero)
                                }
                                
                                //not yet solved
                            } else {
                                NavigationLink(destination: EmotionSelectView(questionData: question, hasDone: false)) {
                                    Image("opendFlower")
                                        .resizable()
                                        .frame(width: 100, height: 90)
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
                                    .resizable()
                                    .frame(width: 100, height: 90)
                                    .padding(.zero)
                                
                            }
                        }
                        // 몇일째의 질문인지 표기
                        Text("Day \(question.questionNum)")
                            .foregroundColor(.theme.secondary)
                            .padding(.bottom, 36)
                    }
                }
            }
            
            Spacer()
            
            Button {
                shareActivated = completeSix
                notCompleteSix = !completeSix
                print("share \(shareActivated), sixComplete \(completeSix)")
            } label: {
                Text(completeSix ? "공유하기" : "\(count)/6")
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(completeSix ? Color("AccentColor") : .theme.secondary)
                    )
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 60)
        }
        // when button is pressed
        .sheet(isPresented: $shareActivated, content: {
            LetterView(questions: questions, startIdx: startIdx)
            
        })
        // when six questions are done => notification => 라빈얼굴
        .sheet(isPresented: $completeSixModal, content: {
            CompleteSixNotifyView()
                .presentationDetents([.fraction(0.66)])
                .presentationDragIndicator(.visible)
        })
        // when not completed => 규니얼굴
        .sheet(isPresented: $notCompleteSix, content: {
            LockView()
                .presentationDetents([.fraction(0.66)])
                .presentationDragIndicator(.visible)
        })
        
        .onAppear{
            checkOpened(questions: questions)
            count = countSolved(questions: questions)
            if count == 6{
                completeSix = true
                completeSixModal = true
                if UserDefaults.standard.bool(forKey: "completeSixModal\(questions.startIndex)") == true{
                    completeSixModal = false
                }
                UserDefaults.standard.set(true, forKey: "completeSixModal\(questions.startIndex)")
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
                    
                    if cnt == 36{
                        UserDefaults.standard.set(true, forKey: "isAllComplete")
                    }
                    else if points.contains(cnt){
                        questionFull[questions.startIndex + cnt].openedDate = DataController().getCurrentDateTime()
                        questionFull[questions.startIndex + cnt].isOpened = true
                    }
                }
            }
        }
    }
}
