//
//  LoverHome.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct LoverHome: View {
    @State var loverName: String = "❤️"
    @State var dayCounter: Bool = true
    @State private var showModal = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    //@State var message = [["너", "가", "너", "무", "좋", "아"]]
    @State var message = [["너", "가", "너", "무", "좋", "아"], ["좋", "은", "게", "죄", "야", "?"], ["그", "건", "아", "니", "잖", "아"]]
    
    var body: some View {
        if dayCounter {
            VStack {
                Text("\(loverName)가 보낸 메시지에여~\n확인해 보십시다")
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(EdgeInsets(top: 149, leading: 0, bottom: 0, trailing: 0))
                GeometryReader { geometry in
                    Path { path in
                        let size = geometry.size.width
                        let nearLine = size * 0.1
                        let farLine = size
                        let middle = size * 0.03
                        path.move(to: .init(x: nearLine, y: middle))
                        path.addLine(to: .init(x: farLine, y: middle))
                    }.stroke(Color(red: 165 / 255, green: 205 / 255, blue: 251 / 255), style: .init(lineWidth: 3.0, dash: [geometry.size.width / 20, geometry.size.width / 20], dashPhase: 0))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                EnvelopeCarouseView()
                
                /*
                ForEach(0..<message.count) { messageNumber in
                    VStack {
                        HStack {
                            Text("\(messageNumber + 1)주차")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(EdgeInsets(top: 20, leading: 15, bottom: -20, trailing: 0))
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 13) {
                                ForEach(0..<message[messageNumber].count) { charNumber in
                                    Button(action: {self.showModal[messageNumber * 6 + charNumber] = true}){
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundColor(.white)
                                                .shadow(color: Color(red: 139 / 255, green: 139 / 255, blue: 139 / 255), radius: 6, x: 0, y: 5)
                                                .frame(width: 140, height: 165)
                                            Text(message[messageNumber][charNumber])
                                                .fontWeight(.bold)
                                                .font(.system(size: 60))
                                                .foregroundColor(Color.black)
                                        }
                                    }
                                }
                            }.padding()
                        }
                        Rectangle()
                            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255))
                            .frame(width:338, height: 1)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        Spacer()
                    }.background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255)]), startPoint: .center, endPoint: .bottom))
                 */
                }
        } else {
            VStack {
                Text("아직 공유받은 메시지가 없어요\n조금만 더 기다려 보아요")
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Image("not fun")
            }
        }
    }
}

struct LoverHome_Previews: PreviewProvider {
    static var previews: some View {
        LoverHome()
    }
}
