//
//  TestSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct TestSheet: View {
    @State var click = [Int](repeating: 0, count: 36)
    @State var clicked = [Int](repeating: 0, count: 36)
    var body: some View {
        ScrollView{
            ForEach(0 ..< 36){ y in
                
                HStack {
                    Text(QuestionList.question[y])
                        .font(.system(size: 22))
                        .padding(.bottom, 20)
                        .padding(.trailing, 30)
                        .padding(.top, 10)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                }
                .padding(.leading, 20)
                
                HStack(spacing: 18){
                    ForEach(1 ..< 6){ index in
                        Button(action:{
                            click[y] = 1
                            clicked[y] = index
                            
                        }){
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(clicked[y] == index ? Color(red: 255/255, green: 151/255, blue: 172/255) : .white)
                                    .overlay(Circle().stroke(clicked[y] == index ? Color(red: 255/255, green: 151/255, blue: 172/255) : Color.gray.opacity(0.5), lineWidth: 1))
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 24))
                                    .opacity(clicked[y] == index ? 1 : 0)
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 5)
                
                HStack{
                    Text("전혀 그렇지 않다")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("매우 그렇다")
                        .foregroundColor(.gray)
                }
                .font(.caption)
                .padding(.leading, 30)
                .padding(.trailing, 40)
                .padding(.bottom, 20)
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
