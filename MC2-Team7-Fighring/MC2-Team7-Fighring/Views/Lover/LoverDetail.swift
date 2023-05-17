//
//  LoverDetail.swift
//  MC2-Team7-Fighring
//
//  Created by 이용준의 Macbook on 2023/05/08.
//

import SwiftUI

struct LoverDetail: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var share: FetchedResults<Sharing>
    @State var shareLetterClicked = 0
    @State var click = true
    @State var clicked = 0
    @Binding var currentIndex: Int
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                HStack(spacing: 4){
                    ForEach(0 ..< 6) { index in
                        ZStack{
                            Button(action: {
                                shareLetterClicked = index
                            }){
                                Circle()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(shareLetterClicked == index ? Color("AccentColor") : Color.theme.detailButton)
                            }
                            Text(share[6 * currentIndex + index].sixLetters!)
                                .foregroundColor(shareLetterClicked == index ? .white : .black)
                                .font(.system(size: 25))
                                .bold()
                        }
                    }
                }
                .frame(width: 340, height: 50)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))

            
            Text("Day \(6 * currentIndex + shareLetterClicked + 1)")
                .frame(width: 302, alignment: .leading)
                .font(.system(size: 34))
                .bold()
                .padding(EdgeInsets(top: 0, leading: 29, bottom: 19.98, trailing: 0))

            Text("\(QuestionList.detailQuestion[6 * currentIndex + shareLetterClicked])")
                .frame(width: 302, height: 120, alignment: .leading)
                .font(.system(size: 25))
                .padding(EdgeInsets(top: 0, leading: 28, bottom: 20, trailing: 0))

            
            HStack(spacing: 18){
                ForEach(0 ..< 5){ index in
                    Button(action:{
                    }){
                        ZStack{
                            Circle()
                                .frame(width: 45, height: 45)
                                .foregroundColor(share[6 * currentIndex + shareLetterClicked].questionAnswer - 1 == index ? Color("AccentColor"): .white)
                                .overlay(Circle().stroke(Color.theme.secondary, lineWidth: 1))
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
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0))
            HStack{
                HStack{
                    Text("전혀 그렇지 않다")
                        .foregroundColor(Color.secondary)
                        .font(.system(size: 15))
                    Spacer()
                    Text("매우 그렇다")
                        .foregroundColor(Color.secondary)
                        .font(.system(size: 15))
                }
                .frame(width: 337)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 88, trailing: 0))
            
            HStack{
                Image("tip")
                    .resizable()
                    .frame(width: 47, height: 19, alignment: .leading)
            }.frame(width: 310, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 34, bottom: 10, trailing: 0))
            VStack{
                Text(Tips.tip[currentIndex])
                    .font(.system(size: 14))
                    .frame(width: 284)
            }
            .frame(width: 332, height: 131)
            .background(Color.theme.detailTextField)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

struct LoverDetail_Previews: PreviewProvider {
    static var previews: some View {
        LoverDetail(currentIndex: .constant(0))
    }
}
