//
//  ButtonComponent.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/14.
//

import SwiftUI

struct ButtonComponent: View {
    let buttonStyle: ButtonStyle
    var color: Color = .accentColor
    let content: () -> String
    let action: () -> Void
    var text: String {
        content()
    }
    
    var body: some View {
        
        Button(action: action) {
            Text(text)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal, buttonStyle == .long ? 30 : 96)
        }
    }
    
    enum ButtonStyle {
        case short
        case long
    }
}

struct ButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponent(buttonStyle: .long) {
            return "fefe"
        } action: {
            print("Hell")
        }
    }
}
