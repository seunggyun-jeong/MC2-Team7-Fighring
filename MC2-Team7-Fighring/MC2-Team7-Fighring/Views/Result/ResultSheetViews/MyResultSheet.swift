//
//  MyResultSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct MyResultSheet: View {
    var hashTags: [String] = ["사랑", "바보", "멋쟁이", "애교쟁이"]
    var content: String = "Ang Lorem Ipsum ay ginagamit na modelo ng industriya ng pagpriprint at pagtytypeset. Ang Lorem Ipsum ang naging regular na modelo simula pa noong 1500s, noong may isang di kilalang manlilimbag and kumuha ng galley ng type at ginulo ang pagkaka-ayos nito upang makagawa ng libro ng mga type specimen. Nalagpasan nito hindi lang limang siglo, kundi nalagpasan din nito ang paglaganap ng electronic typesetting at nanatiling parehas. Sumikat ito noong 1960s kasabay ng pag labas ng Letraset sheets na mayroong mga talata ng Lorem Ipsum, at kamakailan lang sa mga desktop publishing software tulad ng Aldus Pagemaker ginamit ang mga bersyon ng Lorem Ipsum."
    
    var body: some View {
        NavigationStack {
            VStack {
                Circle()
                    .frame(width: 254)
                    .padding(.bottom, 27)
                
                Text("\"너 없이 못살아\"형")
                    .font(.title)
                    .bold()
                
                HStack {
                    ForEach(hashTags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.bottom, 57)
                
                Text(content)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 38)
                    .padding(.bottom, 16)
                
                Button("확인") {
                    // TODO: Confirm
                }
                
                Spacer()
            }
            .navigationTitle("나의 유형은?")
        }
    }
}

struct MyResultSheet_Previews: PreviewProvider {
    static var previews: some View {
        MyResultSheet()
    }
}
