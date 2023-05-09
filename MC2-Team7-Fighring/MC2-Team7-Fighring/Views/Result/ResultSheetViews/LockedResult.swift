//
//  LockedResult.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct LockedResult: View {
    
    @State var isLocked: Bool
    @Binding var isConfirm: Bool
    
    var body: some View {
        VStack {
            Image(isLocked ? "notFIN" : "FIN")
                .padding(.bottom, 60)
                .frame(width: 236, height: 236)
            Text(isLocked ? "아직 여정이 끝나지 않았어요." : "모든 여정을 마쳤어요!")
                .font(.title2)
                .bold()
            
            Text(isLocked ? "여정을 마치면, 결과를 확인할 수 있어요!" : "아래 버튼을 터치하여 유형을 확인해보세요.")
                .font(.subheadline)
                .padding(.bottom, 31)
                .foregroundColor(.secondary)
                .bold()
            
            Button("결과확인") {
                // 결과 확인 기능
                isConfirm.toggle()
            }
            .disabled(isLocked)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct lockedResult_Previews: PreviewProvider {
    static var previews: some View {
        LockedResult(isLocked: true, isConfirm: .constant(true))
    }
}
