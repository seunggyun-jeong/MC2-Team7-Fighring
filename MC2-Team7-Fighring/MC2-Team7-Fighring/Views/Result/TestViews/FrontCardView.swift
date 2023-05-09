//
//  FrontCardView.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct FrontCardView: View {
    @Binding var degree : Double
    var attachmentType: AttachmentType
    var hashTags: [String] = ["사랑", "바보", "멋쟁이", "애교쟁이"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            
            VStack {
                // TODO: 유형별 멘트 뽑아오기 (random)
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Text(quotes[attachmentType.rawValue].randomElement()!)
                }
                .padding(.horizontal, 22)
                .padding(.top, 23)
                .frame(height: 84)
                .padding(.bottom, 21)
                
                Circle()
                    .frame(width: 300)
                    .padding(.bottom, 66)
                
                HStack {
                    ForEach(hashTags, id: \.self) { tag in
                        Text("#\(tag)")
                    }
                }
                .padding(.bottom, 33)
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        .onAppear {
            
        }
    }
}

struct FrontCardView_Previews: PreviewProvider {
    static var previews: some View {
        FrontCardView(degree: .constant(0.0), attachmentType: .anxious)
    }
}
