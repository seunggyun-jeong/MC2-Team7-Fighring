//
//  leadingBackBtnView.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/11.
//

import SwiftUI

struct LeadingBackBtnView: View {
    @Environment(\.presentationMode) var presentationMode
    var dismissDest: String
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text(dismissDest)
            }
        }
    }
}

