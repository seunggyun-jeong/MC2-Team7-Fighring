//
//  LoverDetail.swift
//  MC2-Team7-Fighring
//
//  Created by 이용준의 Macbook on 2023/05/08.
//

import SwiftUI

struct LoverDetail: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var share: FetchedResults<Sharing>
    @State var shareLetter = ["너", "없", "이", "못", "살", "아"]
    @State var shareLetterClicked = 0
    @State var loverName: String = "❤️"
    @State var tip: String = "위의 답변을 가지고 서로의 생각을 조금 더 들어보는\n 시간을 갖는 것은 어떨까요?\n\n대화를 나누고 서로를 조금 더 이해해보아요!"
    @State var click = true
    @State var clicked = 0
    @Binding var currentIndex: Int
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                HStack(spacing: 0){
                    ForEach(0 ..< 6) { index in
                        ZStack{
                            Button(action: {
                                shareLetterClicked = index
                            }){
                                Image("blueCircle")
                                    .frame(width: 45, height: 45)
                                    .opacity(shareLetterClicked == index ? 1 : 0)
                            }
                            Text(share[6 * currentIndex + index].sixLetters!)
                                .foregroundColor(shareLetterClicked == index ? .white : .black)
                                .font(.system(size: shareLetterClicked == index ? 30: 25))
                                .bold()
                        }
                    }
                }
                .frame(width: 340, height: 102)
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 56, trailing: 0))

            
            Text("\(QuestionList.question[6 * currentIndex + shareLetterClicked])")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 25))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 38, trailing: 0))
            
            HStack(spacing: 18){
                ForEach(0 ..< 5){ index in
                    Button(action:{
                        print(share.count)
                        print(share[0])
                        print(currentIndex)
                    }){
                        ZStack{
                            Circle()
                                .frame(width: 45, height: 45)
                                .foregroundColor(share[6 * currentIndex + shareLetterClicked].questionAnswer - 1 == index ? .pink: .white)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                            if(share[6 * currentIndex + shareLetterClicked].questionAnswer - 1 == index){
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 24))
                            }
                        }
                    }
                   .disabled(true)
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
            
            Text("Tip!")
                .foregroundColor(.blue)
                .font(.system(size: 20))
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            VStack(){
                Text(tip)
                    .font(.system(size: 14))
                    .padding(EdgeInsets(top: 23, leading: 0, bottom: 0, trailing: 0))
            }
            .frame(width: 332, height: 131, alignment: .top)
            .background(.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

struct LoverDetail_Previews: PreviewProvider {
    static var previews: some View {
        LoverDetail(currentIndex: .constant(1))
    }
}
