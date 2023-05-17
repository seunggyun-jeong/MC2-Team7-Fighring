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
    private let avoidantScore: Double = UserDefaults.standard.double(forKey: "avoidantScore")
    private let anxiousScore: Double = UserDefaults.standard.double(forKey: "anxiousScore")
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            
            VStack {
                Spacer()
                
                Text(TypeData.name[attachmentType.rawValue])
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Image(TypeData.imageName[attachmentType.rawValue])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 138)
                    .padding(.bottom, 14)
                
                HStack(spacing: 5) {
                    CustomGauge(current: 100 - avoidantScore, gaugeName: "타인긍정")
                        .frame(width: 70)
                    CustomGauge(current: 100 - anxiousScore, gaugeName: "자기긍정")
                        .frame(width: 70)
                }
                
                Spacer()
                
                Text(TypeData.description[attachmentType.rawValue])
                    .font(.callout)
                    .padding(.horizontal, 27)
                    .padding(.bottom, 32)
                    .multilineTextAlignment(.center)
                    .allowsTightening(true)
                
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
