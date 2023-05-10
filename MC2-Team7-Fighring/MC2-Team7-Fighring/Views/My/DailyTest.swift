//
//  DailyTest.swift
//  MC2-Team7-Fighring
//
//  Created by Ko Seokjun on 2023/05/08.
//

import SwiftUI

struct DailyTest: View {
    @State var loverName: String = "❤️"
    @State var question: String = "Q1. 나는 (❤️)에게 나의 마음을\n 표현하는걸 머뭇거리게 돼.. "
    @State var day = "Day 1"
    @State var click = false
    @State var clicked = 0
    @State var reason: String = ""
    
    var body: some View {
        VStack(alignment: .center){
            Text(day)
                .font(.system(size: 34))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 41, trailing: 0))
                .bold()
            
            Text("\(question)")
                .font(.system(size: 25))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 38, trailing: 0))
            
            HStack(spacing: 18){
                ForEach(0 ..< 5){ index in
                    Button(action:{
                        click = true
                        clicked = index
                    }){
                        if index == clicked {
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(click ? .pink: .white)
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                if(click){
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 24))
                                }
                            }
                        }
                        else{
                            Circle()
                                .frame(width: 45, height: 45)
                                .foregroundColor(.white)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
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
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 66, trailing: 0))
            ZStack(alignment: .topLeading){
                TextEditor(text: $reason)
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .scrollContentBackground(.hidden)
                    .padding(EdgeInsets(top: 20, leading: 21, bottom: 0, trailing: 0))

                if reason.isEmpty {
                    Text("이유에 대해 생각해봐요!")
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 50, leading: 84, bottom: 0, trailing: 0))
                }
            }
            .frame(width: 336, height: 124, alignment: .top)
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 69, trailing: 0))
            
            Button(action: {print("hi")}){
                ZStack{
                    Rectangle()
                        .frame(width: 99, height: 51)
                        .cornerRadius(5)
                        .foregroundColor(.gray)
                    Text("저장하기")
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct DailyTest_Previews: PreviewProvider {
    static var previews: some View {
        DailyTest()
    }
}
