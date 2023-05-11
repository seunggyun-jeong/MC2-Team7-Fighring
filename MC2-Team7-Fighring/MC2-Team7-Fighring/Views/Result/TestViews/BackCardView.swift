//
//  BackCardView.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct BackCardView: View {
    @Binding var degree : Double
    var attachmentType: AttachmentType
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            
            VStack {
                Text("\"유형 이름\"")
                    .font(.title)
                    .bold()
                    .padding(.top, 32)
                
                Image("Bichon_avoidant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 173)
                    .padding(.bottom, 14)
                
                HStack(spacing: 5) {
                    Circle()
                        .frame(width: 70)
                        .foregroundColor(.green)
                    Circle()
                        .frame(width: 70)
                        .foregroundColor(.yellow)
                    Circle()
                        .frame(width: 70)
                        .foregroundColor(.orange)
                    Circle()
                        .frame(width: 70)
                        .foregroundColor(.purple)
                }
                
                Spacer()
                
                Text(TypeData.description[attachmentType.rawValue])
                    .font(.callout)
                    .padding(.horizontal, 27)
                    .padding(.bottom, 32)
                    .multilineTextAlignment(.center)
                
                Spacer()

            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(degree: .constant(0.0), attachmentType: .secure)
    }
}
