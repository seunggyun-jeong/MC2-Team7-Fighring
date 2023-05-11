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
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("상대방의 이름을\n입력해주세요!")
                .font(.title.bold())
                .multilineTextAlignment(.leading)
                .padding(.top, 75)
                .padding(.bottom, 19)
            
            Text("*입력시 수정 불가")
                .foregroundColor(.theme.secondary)
                .fontWeight(.bold)
                .padding(.bottom, 44)
            
            TextField("상대방의 이름을 입력해 주세요", text: $loverName)
                .textFieldStyle(TextFieldBackground(systemImageString: "pencil"))
            
            Spacer()
            
            Button {
                DataController().addData(context: managedObjectContext)
                isFirstLaunch = false
                UserDefaults.standard.set(loverName, forKey: "loverName")
                print(UserDefaults.standard.string(forKey: "loverName")) // UserDefaults에 저장된 값 불러오는 방법
            } label: {
                Text("저장하기")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .fontWeight(.semibold)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(loverName.isEmpty ? .secondary : .accentColor)
                    )
            }
            .disabled(loverName.isEmpty)
            .padding(.bottom, 50)
            
            
            Spacer()
        }
        .padding(.horizontal, 30)
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
