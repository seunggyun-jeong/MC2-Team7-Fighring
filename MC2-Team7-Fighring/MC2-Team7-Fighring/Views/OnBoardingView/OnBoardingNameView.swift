//
//  OnBoardingNameView.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/08.
//

import SwiftUI

struct OnBoardingNameView: View {
    @State private var loverName: String = ""
    @Binding var isFirstLaunch: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.theme.secondary)
                }
            }
            .padding(.vertical, 24)
            .padding(.trailing, 16)
            
            Group {
                Text("상대방의 이름을\n입력해주세요!")
                    .font(.title.bold())
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                    .allowsTightening(true)
                
                Text("*입력시 수정 불가")
                    .foregroundColor(.theme.secondary)
                    .fontWeight(.bold)
                    .padding(.bottom, 44)
                
                TextField("상대방의 이름을 입력해 주세요", text: $loverName)
                    .textFieldStyle(TextFieldBackground(systemImageString: "pencil"))
                    .disableAutocorrection(true)
                    .padding(.bottom, 30)
            }
            .padding(.horizontal, 30)
            
            ButtonComponent(buttonStyle: .long) {
                "저장하기"
            } action: {
                DataController().addData(context: managedObjectContext)
                
                isFirstLaunch = false
                UserDefaults.standard.set(loverName, forKey: "loverName")
                UserDefaults.standard.set(0, forKey: "week")
            }
            .disabled(loverName.isEmpty)
            
            
            Spacer()
        }
    }
}


struct TextFieldBackground: TextFieldStyle {
    
    let systemImageString: String
    
    // Hidden function to conform to this protocol
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(red: 118/255, green: 118/255, blue: 128/255).opacity(0.12))
                .frame(height: 40)
            
            HStack {
                Image(systemName: systemImageString)
                
                configuration
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
}

struct OnBoardingNameView_preview: PreviewProvider {
    static var previews: some View {
        OnBoardingNameView(isFirstLaunch: .constant(true))
    }
}
