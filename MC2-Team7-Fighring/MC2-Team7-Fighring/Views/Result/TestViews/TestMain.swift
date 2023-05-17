//
//  TestMain.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct TestMain: View {
    @State private var showOtherType: Bool = false
    private let userAttachmentType: AttachmentType = AttachmentType(rawValue: UserDefaults.standard.integer(forKey: "userAttachmentType")) ?? .secure
    
    // Card Flip
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
        
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.1
    
    var body: some View {
        NavigationStack {
            VStack {
                // 다른 유형 보기
                HStack {
                    Button {
                        // 다른 유형 보기 시트 On
                        showOtherType.toggle()
                    } label: {
                        Label("다른 유형 보기", systemImage: "magnifyingglass")
                    }
                    Spacer()
                }
                .padding(.top, 11)
                .padding(.bottom, 11)
                
                ZStack {
                    // 카드
                    FrontCardView(degree: $frontDegree, attachmentType: userAttachmentType)
                    BackCardView(degree: $backDegree, attachmentType: userAttachmentType)
                }
                .padding(.bottom, 37)
                .onTapGesture {
                    flipCard()
                }
                
                NavigationLink {
                    TestSheet()
                } label: {
                    Text("지금의 나는 어떨까?")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.bottom, 29)
                
                Text("상세내용 보러가기 􀆊")
                    .font(.footnote)
                    .foregroundColor(.theme.teritary)
                
                Spacer()
            }
            .padding(.horizontal, 30)
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
