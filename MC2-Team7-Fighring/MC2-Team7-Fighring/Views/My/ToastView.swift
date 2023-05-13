//
//  ToastView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/13.
//

import SwiftUI

struct ToastView: View {
    var text: String
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                Color.black.opacity(0.3)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 10)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                Text(text)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            
        }
    }
}
