//
//  OtherSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct OtherSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selection: AttachmentType = .secure
    
    var body: some View {
        VStack {
            HStack {
                Text("또 다른 유형은 뭐가 있을까?")
                    .bold()
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.top, 33)
            
            Divider()
                .padding(.vertical, 5)
            
            // TODO: UIKit으로 다시 구현해야 함
            TabView(selection: $selection) {
                Type1(attachmentType: .secure)
                    .tag(AttachmentType.secure)
                
                Type1(attachmentType: .anxious)
                    .tag(AttachmentType.anxious)
                
                Type1(attachmentType: .avoidant)
                    .tag(AttachmentType.avoidant)
                
                Type1(attachmentType: .fearful)
                    .tag(AttachmentType.fearful)
            }
            .tabViewStyle(.page)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .padding(.horizontal, 16)
    }
}

struct Type1: View {
    let attachmentType: AttachmentType
    
    var body: some View {
        VStack {
            Text(TypeData.name[attachmentType.rawValue])
                .font(.title)
                .foregroundColor(.secondary)
                .bold()
                .padding(.bottom, 26)
            
            Image(TypeData.imageName[attachmentType.rawValue])
                .resizable()
                .scaledToFit()
                .frame(width: 265)
                .padding(.bottom, 33)
            
            HStack {
                ForEach(TypeData.tags[attachmentType.rawValue], id: \.self) { tag in
                    Text("#\(tag)")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct OtherSheet_Previews: PreviewProvider {
    static var previews: some View {
        OtherSheet()
    }
}
