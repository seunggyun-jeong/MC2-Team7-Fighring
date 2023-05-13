//
//  EmotionCarouselView.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/09.
//

import SwiftUI

struct EmotionCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var questionData: FetchedResults<Question>.Element
    var hasDone: Bool
    
    @StateObject var emotionStorage = EmotionStore()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    ForEach(emotionStorage.items) { item in
                        VStack {
                            Image(item.emotion)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220)
                            
                        }
                        .scaleEffect(1.0 - abs(getDistance(item.id)) * 0.6 )
                        .opacity(1.0 - abs(getDistance(item.id)) * 0.55 )
                        .offset(x: getMyXOffset(item.id), y: 0)
                        .zIndex(1.0 - abs(getDistance(item.id)) * 0.1)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            draggingItem = snappedItem + value.translation.width / 100
                        }
                        .onEnded { value in
                            withAnimation {
                                draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                                draggingItem = round(draggingItem).remainder(dividingBy: Double(emotionStorage.items.count))
                                snappedItem = draggingItem
                            }
                        }
                )
                .padding(.bottom, 100)
                
            }
            
            NavigationLink(destination: DailyTest(questionData: questionData, userEmotion: getCenterItem(), hasDone: hasDone), label: {
                Text("선택완료")
                    .font(.body.bold())
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                    )
            })
            .simultaneousGesture(TapGesture().onEnded {
                if hasDone {
                    // 저장하기
                    DataController().answerQuestion(question: questionData, questionAnswer: questionData.questionAnswer, questionNum: questionData.questionNum, userReason: questionData.userReason ?? "", userEmotion: Int32(getCenterItem()), context: managedObjectContext)
                    presentationMode.wrappedValue.dismiss()
                    
                }
            })
            
        }
    }
    
    func getDistance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(emotionStorage.items.count))
    }
    
    func getMyXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(emotionStorage.items.count) * getDistance(item)
        return sin(angle) * 200
    }
    
    // 선택된 항목 String 값 가져오기
    func getCenterItem() -> Int {
        let centerIndex = Int(snappedItem.rounded()) % emotionStorage.items.count
        return centerIndex < 0 ? emotionStorage.items.count + centerIndex : centerIndex
    }
}

//struct EmotionCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmotionCarouselView()
//    }
//}
