//
//  MyResultSheet.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/08.
//

import SwiftUI

struct MyResultSheet: View {
    @Binding var is36DaysLater: Bool
    var attachmentType: AttachmentType = .secure
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    GifImage("Bichon_avoidant")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 254)
                        .padding(.bottom, 27)
                    
                    Text("\"너 없이 못살아\"형")
                        .font(.title)
                        .bold()
                    
                    HStack {
                        ForEach(TypeData.tags[attachmentType.rawValue], id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Text(TypeData.description[attachmentType.rawValue])
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 38)
                        .padding(.bottom, 16)
                    
                    HStack(spacing: 10) {
                        CustomGauge(current: 33, gaugeName: "회피성")
                        CustomGauge(current: 33, gaugeName: "회피성")
                        CustomGauge(current: 33, gaugeName: "회피성")
                        CustomGauge(current: 33, gaugeName: "회피성")
                    }
                    
                    VStack {
                        Divider()
                        
                        Button("확인") {
                            // TODO: Confirm
                            is36DaysLater.toggle()
                        }
                    }
                    .frame(width: 128)
                    .padding(.bottom, 22)
                    
                    Spacer()
                }
            }
            .navigationTitle("나의 유형은?")
        }
    }
}

struct CustomGauge: View {
    @State var current: Double
    @State var gaugeName: String
    @State private var minValue = 0.0
    @State private var maxValue = 100.0
    
    var body: some View {
        Gauge(value: current, in: minValue...maxValue) {
            Text(gaugeName)
                .foregroundColor(.accentColor)
        } currentValueLabel: {
            Text("\(Int(current))")
                .foregroundColor(Color.accentColor)
        }
        .gaugeStyle(AccessoryCircularGaugeStyle())
        .tint(.accentColor)
    }
}

struct MyResultSheet_Previews: PreviewProvider {
    static var previews: some View {
        MyResultSheet(is36DaysLater: .constant(false))
    }
}
