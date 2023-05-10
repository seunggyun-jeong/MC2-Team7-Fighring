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
                }
                EnvelopeCarouseView()
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
