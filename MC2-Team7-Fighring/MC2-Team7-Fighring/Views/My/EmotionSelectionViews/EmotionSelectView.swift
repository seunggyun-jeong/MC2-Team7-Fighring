//
//  EmotionSelectView.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/09.
//

import SwiftUI

struct EmotionSelectView: View {
    var questionData: FetchedResults<Question>.Element
    var hasDone: Bool
    
    var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading){
                        Text("오늘하루")
                        Text("**나의 감정**은 어땠나요?")
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 30)
                    .font(.title)
                    
                    Spacer()
                }
                
                Spacer()
                
                EmotionCarouselView(questionData: questionData, hasDone: hasDone)
                
                Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: LeadingBackBtnView(dismissDest: hasDone ? "" : "36 days"))
    }
    
}



//struct EmotionSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmotionSelectView()
//    }
//}

