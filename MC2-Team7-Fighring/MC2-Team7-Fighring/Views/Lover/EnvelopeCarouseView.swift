//
//  EnvelopeCarouseView.swift
//  MC2-Team7-Fighring
//
//  Created by 이용준의 Macbook on 2023/05/09.
//

import SwiftUI

struct EnvelopeCarouseView: View {
    @StateObject var envelopeStorage = EnvelopeStore()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    ForEach(envelopeStorage.items) { item in
                        VStack {
                            Image(item.envelope)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220)
                        }
                        .scaleEffect(1.0 - abs(getDistance(item.id)) * 0.6 )
                        .opacity(1.0 - abs(getDistance(item.id)) * 0.55 )
                        .offset(x: getMyXOffset(item.id), y: 0)
                        .zIndex(1.0 - abs(getDistance(item.id)) * 0.1)
                    }
                }.gesture(
                    DragGesture()
                        .onChanged { value in
                            draggingItem = snappedItem + value.translation.width / 100
                        }
                        .onEnded { value in
                            withAnimation {
                                draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                                draggingItem = round(draggingItem).remainder(dividingBy: Double(envelopeStorage.items.count))
                                snappedItem = draggingItem
                            }
                        }
                ).padding(.bottom, 100)
            }
        }
    }
    
    func getDistance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(envelopeStorage.items.count))
    }
    
    func getMyXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(envelopeStorage.items.count) * getDistance(item)
        return sin(angle) * 200
    }
}

struct EnvelopeCarouseView_Previews: PreviewProvider {
    static var previews: some View {
        EnvelopeCarouseView()
    }
}

