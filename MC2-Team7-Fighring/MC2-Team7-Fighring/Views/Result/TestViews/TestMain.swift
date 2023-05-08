//
//  TestMain.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct TestMain: View {
    @State private var showOtherType: Bool = false
    
    // Card Flip
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
        
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3
    
    var body: some View {
        NavigationStack {
            VStack {
                // 다른 유형 보기
                HStack {
                    Button {
                        // 다른 유형 보기 시트 On
                        showOtherType.toggle()
                    } label: {
                        Label("다른 유형 보기", systemImage: "plus.app.fill")
                    }
                    Spacer()
                }
                .padding(.bottom, 15)
                
                ZStack {
                    // 카드
                    FrontCardView(degree: $frontDegree)
                    BackCardView(degree: $backDegree)
                }
                .padding(.bottom, 37)
                .onTapGesture {
                    flipCard()
                }
                
                NavigationLink("검사하러 가기", destination: TestSheet())
                
                Spacer()
            }
            .padding(.horizontal)
            .sheet(isPresented: $showOtherType) {
                OtherSheet()
                    .presentationDetents([.fraction(0.75)])
            }
        }
    }
    
    func flipCard () {
            isFlipped = !isFlipped
            if isFlipped {
                withAnimation(.linear(duration: durationAndDelay)) {
                    backDegree = 90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    frontDegree = 0
                }
            } else {
                withAnimation(.linear(duration: durationAndDelay)) {
                    frontDegree = -90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    backDegree = 0
                }
            }
        }
    
}

struct TestMain_Previews: PreviewProvider {
    static var previews: some View {
        TestMain()
    }
}
