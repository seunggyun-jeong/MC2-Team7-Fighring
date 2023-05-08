//
//  LoadingView.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct LoadingView: View {
    @State var progressGauge: Float = 0.0
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 261)
                .padding(.bottom, 53)
            
            ProgressView(value: progressGauge)
                .padding(.horizontal, 26)
            
            Text("유형 분석 중...")
                .font(.caption)
                .padding(.bottom, 63)
            
            Group {
                Text("Tip!")
                    .bold()
                Text("존 볼비의 애착 이론에 기반하여 제작되었어요!")
            }
            .foregroundColor(.secondary)
        }
        .onAppear {
            // TODO: 부드러운 효과
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if progressGauge >= 1.0 {
                    timer.invalidate() // Timer 중지
                }
                
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                    addGauge()
                    print(progressGauge)
                }
            }
        }
    }
    
    func addGauge() {
        progressGauge += 0.1
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
