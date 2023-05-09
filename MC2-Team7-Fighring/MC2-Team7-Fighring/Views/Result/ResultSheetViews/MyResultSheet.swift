//
//  MyResultSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct MyResultSheet: View {
    @Binding var is36DaysLater: Bool
    var attachmentType: AttachmentType = .secure
    
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
                    ForEach(TypeData.tags[attachmentType.rawValue], id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.bottom, 57)
                
                Text(TypeData.description[attachmentType.rawValue])
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 38)
                    .padding(.bottom, 16)
                
                Button("확인") {
                    // TODO: Confirm
                    is36DaysLater.toggle()
                }
                .padding(.bottom, 22)
                
                Spacer()
            }
            .navigationTitle("나의 유형은?")
        }
    }
}

struct MyResultSheet_Previews: PreviewProvider {
    static var previews: some View {
        MyResultSheet(is36DaysLater: .constant(false))
    }
}
