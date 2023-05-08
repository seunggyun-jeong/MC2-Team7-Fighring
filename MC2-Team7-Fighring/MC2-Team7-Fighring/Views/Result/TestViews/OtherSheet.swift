//
//  OtherSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct OtherSheet: View {
    @State private var selection: typeTab = .type1
    
    enum typeTab {
        case type1
        case type2
        case type3
        case type4
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("또 다른 유형은 뭐가 있을까?")
                    .bold()
                Spacer()
                Button {
                    // 닫기 기능
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.top, 33)
            
            Divider()
                .padding(.vertical, 5)
            
            // TODO: UIKit으로 다시 구현해야 함
            TabView(selection: $selection) {
                Type1()
                    .tag(typeTab.type1)
                
                Type1()
                    .tag(typeTab.type2)
                
                Type1()
                    .tag(typeTab.type3)
                
                Type1()
                    .tag(typeTab.type4)
            }
            .tabViewStyle(.page)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .padding(.horizontal, 16)
    }
}

struct Type1: View {
    var hashTags: [String] = ["사랑", "바보", "멋쟁이", "애교쟁이"]
    
    var body: some View {
        VStack {
            Text("유형 이름")
                .font(.title)
                .foregroundColor(.secondary)
                .bold()
                .padding(.bottom, 26)
            
            Circle()
                .frame(width: 265)
                .padding(.bottom, 33)
            
            HStack {
                ForEach(hashTags, id: \.self) { tag in
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
