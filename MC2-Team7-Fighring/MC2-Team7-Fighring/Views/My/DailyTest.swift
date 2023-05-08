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
            
            HStack(spacing: 13){
                VStack{
                    Circle()
                        .frame(width: 66.68, height: 66.68)
                        .foregroundColor(.pink)
                        .overlay(Circle().stroke())
                    Text("그렇지 않다")
                }
                VStack{
                    Circle()
                        .frame(width: 47.47, height: 47.47)
                        .foregroundColor(.white)
                        .overlay(Circle().stroke())
                    Text(" ")
                }
                VStack{
                    Circle()
                        .frame(width: 39.55, height: 39.55)
                        .foregroundColor(.white)
                        .overlay(Circle().stroke())
                    Text(" ")
                }
                VStack{
                    Circle()
                        .frame(width: 47.47, height: 47.47)
                        .foregroundColor(.white)
                        .overlay(Circle().stroke())
                    Text(" ")
                }
                VStack{
                    Circle()
                        .frame(width: 66.68, height: 66.68)
                        .foregroundColor(.green)
                        .overlay(Circle().stroke())
                    Text("그렇다")
                }
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 66, trailing: 0))
            
            
            TextField("이유에 대해 생각해봐요!", text: $reason)
                .font(.system(size: 17))
                .frame(width: 336, height: 124, alignment: .top)
                .background(.gray)
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
