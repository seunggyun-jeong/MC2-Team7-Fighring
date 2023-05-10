//
//  TestSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct TestSheet: View {
    @State var click = [Int](repeating: 0, count: 32)
    @State var clicked = [Int](repeating: 0, count: 32)
    var body: some View {
        ScrollView{
            ForEach(0 ..< 32){ y in
                Text(QuestionList.question[y])
                    .font(.system(size: 25))
                    .frame(width: 325, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 21, trailing: 0))
                HStack(spacing: 18){
                    ForEach(1 ..< 6){ index in
                        Button(action:{
                            click[y] = 1
                            clicked[y] = index
                            
                        }){
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(clicked[y] == index ? .pink: .white)
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 24))
                                    .opacity(clicked[y] == index ? 1 : 0)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                HStack{
                    HStack{
                        Text("전혀 그렇지 않다")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                        Spacer()
                        Text("매우 그렇다")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }
                    .frame(width: 337)
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
            }
            Button(action: {
                
            }){
                VStack{
                    Rectangle()
                        .frame(width: 135, height: 0.8)
                        .foregroundColor(.gray)
                    Text("확인")
                }
                
            }
            .frame(width: 135, height: 44)
            .disabled(click.min() == 0 ? true : false)
        }
    }
}

struct TestSheet_Previews: PreviewProvider {
    static var previews: some View {
        TestSheet()
    }
}
