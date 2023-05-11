//
//  LoverHome.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct LoverHome: View {
    @State var currentIndex: Int = 0
    @State var loverName: String = "❤️"
    @State var envelopes: [Envelope] = []
    @State var week: Int = 6
    
    var body: some View {
        if week != 0 {
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
                        let farLine = size * 0.9
                        let middle = size * 0.03
                        path.move(to: .init(x: nearLine, y: middle))
                        path.addLine(to: .init(x: farLine, y: middle))
                    }.stroke(Color(red: 165 / 255, green: 205 / 255, blue: 251 / 255), style: .init(lineWidth: 3.0, dash: [geometry.size.width / 20, geometry.size.width / 20], dashPhase: 0))
                }
                Button{
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 103, height: 32)
                            .opacity(week == 6 ? 0.55 : 1.0)
                            .foregroundColor(week == 6 ? Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255) : Color(red: 199 / 255, green: 199 / 255, blue: 204 / 255))
                        Text("유형보기")
                            .foregroundColor(.white)
                    }
                }.padding(EdgeInsets(top: -210, leading: 0, bottom: 0, trailing: 0))
                EnvelopeCarouseView(index: $currentIndex, items: envelopes) {envelope in
                    GeometryReader{proxy in
                        
                        let size = proxy.size
                        VStack {
                            Image(envelope.envelopeImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width)
                                .onTapGesture {
                                    print("\(currentIndex + 1)")
                                }
                        }
                    }
                }
                .padding(.vertical, 80)
                .padding(EdgeInsets(top: -200, leading: 0, bottom: 0, trailing: 0))
                
                HStack(spacing: 10) {
                    ForEach(envelopes.indices,id: \.self){index in
                        Circle()
                            .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                            .frame(width: 10, height: 10)
                            .scaleEffect(currentIndex == index ? 1.4 : 1)
                            .animation(.spring(), value: currentIndex == index)
                    }
                }.padding(EdgeInsets(top: -120, leading: 0, bottom: 0, trailing: 0))
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
                Image("notFIN")
            }
        }
    }
}

struct LoverHome_Previews: PreviewProvider {
    static var previews: some View {
        LoverHome()
    }
}
