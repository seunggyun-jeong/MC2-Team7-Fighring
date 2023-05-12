//
//  LoverHome.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct LoverHome: View {
    var loverName = UserDefaults.standard.string(forKey: "loverName") ?? "리아❤️"
    @State var envelopes: [Envelope] = []
    @State var week: Int = Envelope.week
    @State var currentIndex: Int = Envelope.week - 1
    @State private var showModal = false
    
    var body: some View {
        if week != 0 {
            VStack {
                HStack {
                    Text("\(loverName)")
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .font(.system(size: 26))
                    Text("가 보낸 메세지에요")
                        .multilineTextAlignment(.center)
                        .fontWeight(.regular)
                        .font(.system(size: 26))
                }.padding(EdgeInsets(top: 90, leading: 0, bottom: 1, trailing: 0))
                Text("확인해볼까요?")
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .font(.system(size: 26))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                
                EnvelopeCarouseView(spacing: -25, trailingSpace: 100, index: $currentIndex, items: envelopes) {envelope in
                    GeometryReader{proxy in
                        let size = proxy.size
                        VStack {
                            Image(envelope.envelopeImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width)
                                .scaleEffect(envelope.envelopeImage == "envelope" + String(currentIndex + 1) ? 1.0 : 0.75)
                                .offset(y: envelope.envelopeImage == "envelope" + String(currentIndex + 1) ? 0.0 : 100)
                                .animation(.easeOut, value: envelope.envelopeImage == "envelope" + String(currentIndex + 1))
                                .onTapGesture {
                                    self.showModal = true
                                }
                                .sheet(isPresented: self.$showModal) {
                                    LoverDetail(currentIndex: currentIndex + 1)
                                }
                        }
                    }
                }
                .padding(.vertical, 80)
                .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
                
                Button{
                    print(envelopes)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 330, height: 60)
                            .foregroundColor(week == 6 ? Color(red: 255 / 255, green: 151 / 255, blue: 172 / 255) : Color(red: 199 / 255, green: 199 / 255, blue: 204 / 255))
                        Text("유형보기")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }.padding(EdgeInsets(top: -150, leading: 0, bottom: 0, trailing: 0))
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear {
                for index in 1...week {
                    envelopes.append(Envelope(envelopeImage: "envelope\(index)"))
                }
            }
            
            .onOpenURL { url in
                print(url)
            }
        } else {
            VStack {
                Text("아직 공유받은 메시지가 없어요\n조금만 더 기다려 보아요")
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Image("yongjun")
            }
        }
    }
}

struct LoverHome_Previews: PreviewProvider {
    static var previews: some View {
        LoverHome()
    }
}
