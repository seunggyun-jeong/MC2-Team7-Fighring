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
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var question: FetchedResults<Question>
    
    var body: some View {
        VStack {
            Image(isLocked ? "lia" : "tamra")
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
            
            ButtonComponent(buttonStyle: .long) {
                "확인하러가기"
            } action: {
                // 결과 확인 기능
                resultAlgorithm()
                isConfirm.toggle()
            }
            .disabled(isLocked)
        }
    }
    
    func resultAlgorithm() {
        var evenData: Int32 = 0
        var oddData: Int32 = 0
        
        for i in 0...35 {
            if i % 2 == 0 {
                evenData += question[i].questionAnswer
                print("----> \(i)의 값 \(question[i].questionAnswer) 짝수 값 \(evenData)")
            } else {
                oddData += question[i].questionAnswer
                print("----> \(i)의 값 \(question[i].questionAnswer) 홀수 값 \(oddData)")
            }
        }
        
        // 회피 점수 및 불안 점수 계산
        let avoidantScore: Double = Double(oddData) / 18
        let anxiousScore: Double = Double(evenData) / 18
        print("----> 불안점수 : \(anxiousScore)")
        print("----> 회피점수 : \(avoidantScore)")
        
        // 각 점수를 5점 만점 -> 100점 만점 환산 (score * 50)
        let exchangedAvoidantScore: Double = avoidantScore * 50
        let exchangedAnxiousScore: Double = anxiousScore * 50
        
        print("----> 환산된 불안점수 : \(exchangedAnxiousScore)")
        print("----> 환산된 회피점수 : \(exchangedAvoidantScore)")
        
        // 회피점수 및 불안점수 저장
        UserDefaults.standard.set(exchangedAvoidantScore, forKey: "avoidantScore")
        UserDefaults.standard.set(exchangedAnxiousScore, forKey: "anxiousScore")
        
        print("----> 저장값 확인 ---> 회피점수 : \(UserDefaults.standard.double(forKey: "avoidantScore")) 불안점수 : \(UserDefaults.standard.double(forKey: "anxiousScore"))")
        
        // 유형 검사
        if avoidantScore < 2.33 {
            if anxiousScore < 2.61 {
                // 안정형
                UserDefaults.standard.set(AttachmentType.secure.rawValue, forKey: "userAttachmentType")
            } else {
                // 불안형
                UserDefaults.standard.set(AttachmentType.anxious.rawValue, forKey: "userAttachmentType")
            }
        } else {
            if anxiousScore < 2.61 {
                // 회피형
                UserDefaults.standard.set(AttachmentType.avoidant.rawValue, forKey: "userAttachmentType")
            } else {
                // 공포형
                UserDefaults.standard.set(AttachmentType.fearful.rawValue, forKey: "userAttachmentType")
            }
        }
        
        print("----> UserType: \(AttachmentType(rawValue: UserDefaults.standard.integer(forKey: "userAttachmentType"))!)")
    }
}

struct lockedResult_Previews: PreviewProvider {
    static var previews: some View {
        LockedResult(isLocked: true, isConfirm: .constant(true))
    }
}
