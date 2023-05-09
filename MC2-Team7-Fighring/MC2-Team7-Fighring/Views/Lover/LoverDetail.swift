//
//  LoverDetail.swift
//  MC2-Team7-Fighring
//
//  Created by 이용준의 Macbook on 2023/05/08.
//

import SwiftUI

struct LoverDetail: View {
    @State var loverName: String = "❤️"
    @State var question: String = "Q1. 나는 (❤️)에게 나의 마음을\n 표현하는걸 머뭇거리게 돼.. "
    @State var tip: String = "위의 답변을 가지고 서로의 생각을 조금 더 들어보는\n 시간을 갖는 것은 어떨까요?\n\n대화를 나누고 서로를 조금 더 이해해보아요!"
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(loverName)의 이야기를 들어보아요~")
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 61, trailing: 0))
            
            Text("\(question)")
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
            
            Text("Tip!")
                .foregroundColor(.blue)
                .font(.system(size: 20))
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            VStack(){
                Text(tip)
                    .font(.system(size: 14))
                    .padding(EdgeInsets(top: 23, leading: 0, bottom: 0, trailing: 0))
                Circle()
                    .frame(width: 73, height: 73)
                    .foregroundColor(.gray)
                    .overlay(Circle().stroke())
                    .offset(x: 120,y: 35)
            }
            .frame(width: 332, height: 218, alignment: .top)
            .background(.white)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

struct LoverDetail_Previews: PreviewProvider {
    static var previews: some View {
        LoverDetail()
    }
}
