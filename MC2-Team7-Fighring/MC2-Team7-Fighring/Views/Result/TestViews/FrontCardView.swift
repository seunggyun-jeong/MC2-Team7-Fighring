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
                    
                    Text(TypeData.quotes[attachmentType.rawValue].randomElement()!)
                }
                .padding(.horizontal, 22)
                .padding(.top, 23)
                .frame(height: 84)
                .padding(.bottom, 58)
                
                GifImage(TypeData.imageName[attachmentType.rawValue])
                    .frame(width: 300)
                    .padding(.bottom, 113)
                
                HStack {
                    ForEach(TypeData.tags[attachmentType.rawValue], id: \.self) { tag in
                        Text("#\(tag)")
                            .bold()
                            .foregroundColor(.accentColor)
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
        FrontCardView(degree: .constant(0.0), attachmentType: .secure)
    }
}
