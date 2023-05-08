//
//  BackCardView.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct BackCardView: View {
    @Binding var degree : Double
    var hashTags: [String] = ["사랑", "바보", "멋쟁이", "애교쟁이"]
    var content: String = "Ang Lorem Ipsum ay ginagamit na modelo ng industriya ng pagpriprint at pagtytypeset. Ang Lorem Ipsum ang naging regular na modelo simula pa noong 1500s, noong may isang di kilalang manlilimbag and kumuha ng galley ng type at ginulo ang pagkaka-ayos nito upang makagawa ng libro ng mga type specimen. Nalagpasan nito hindi lang limang siglo, kundi nalagpasan din nito ang paglaganap ng electronic typesetting at nanatiling parehas. Sumikat ito noong 1960s kasabay ng pag labas ng Letraset sheets na mayroong mga talata ng Lorem Ipsum, at kamakailan lang sa mga desktop publishing software tulad ng Aldus Pagemaker ginamit ang mga bersyon ng Lorem Ipsum."
    
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
                
                HStack {
                    ForEach(hashTags, id: \.self) { tag in
                        Text("#\(tag)")
                    }
                }
                .padding(.bottom, 10)
                
                Circle()
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
                .padding(.bottom, 10)
                
                Text(content)
                    .padding(.horizontal, 27)
                    .padding(.bottom, 32)
                    .multilineTextAlignment(.center)

            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(degree: .constant(0.0))
    }
}
