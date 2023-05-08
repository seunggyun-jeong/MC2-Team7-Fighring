//
//  TestMain.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct TestMain: View {
    @State private var showOtherType: Bool = false
    
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
                
                // 카드
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                    CardView()
                }
                .padding(.bottom, 37)
                
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
}

struct TestMain_Previews: PreviewProvider {
    static var previews: some View {
        TestMain()
    }
}
