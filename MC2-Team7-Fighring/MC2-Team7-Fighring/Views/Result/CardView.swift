//
//  CardView.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct CardView: View {
    var hashTags: [String] = ["사랑", "바보", "멋쟁이", "애교쟁이"]
    
    var body: some View {
        VStack {
            // TODO: 유형별 멘트 뽑아오기 (random)
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Text("\"너에게 더 좋은 사람이 되고 싶어!\"")
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
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
