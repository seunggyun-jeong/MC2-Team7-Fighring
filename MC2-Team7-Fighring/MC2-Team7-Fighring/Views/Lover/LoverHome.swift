//
//  LoverHome.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct LoverHome: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.questionNum)]) var share: FetchedResults<Sharing>
    @Environment(\.dismiss) var dismiss
    var loverName = UserDefaults.standard.string(forKey: "loverName") ?? "리아❤️"
    @State var envelopes: [Envelope] = [Envelope(envelopeImage: "envelope1"), Envelope(envelopeImage: "envelope2"), Envelope(envelopeImage: "envelope3"), Envelope(envelopeImage: "envelope4"), Envelope(envelopeImage: "envelope5"), Envelope(envelopeImage: "envelope6")]
    @Binding var week: Int
    @Binding var currentIndex: Int
    @State private var showModal = false
    @State private var showTypeSheet = false
    @ObservedObject var envelopeIndex = EnvelopeIndex()
    
    var body: some View {
        if envelopeIndex.week != 0 {
            VStack {
                HStack(spacing: 0) {
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
                
                
                EnvelopeCarouseView(spacing: -25, trailingSpace: 100, currentIndex: $envelopeIndex.currentIndex_view, index: $currentIndex, items: envelopes) {envelope in //week: $week, current: $current, currentIndex: week - 1,
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
                                    LoverDetail(currentIndex: $currentIndex)
                                }
                        }
                    }
                }
                .padding(.vertical, 80)
                .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
                
                ButtonComponent(buttonStyle: .long, color: week != 6 ? Color.theme.secondary : .accentColor) {
                    "\(loverName)의"+" 유형보기"
                } action: {
                    showTypeSheet.toggle()
                }
                .padding(.bottom, 60)
                .disabled(week != 6)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $showTypeSheet) {
                MyResultSheet(isGetResult: .constant(false), showTypeSheet: $showTypeSheet, attachmentType: resultAlgorithm().0, avoidantScore: resultAlgorithm().2
                              , anxiousScore: resultAlgorithm().1, isMyResult: false) {
                    dismiss()
                }
            }
        } else {
            VStack {
                Image("yongjun")
                    .frame(height: 249)
                    .onAppear {
                        print(envelopeIndex.week)
                    }
                
                Text("아직 공유받은 메시지가 없어요\n조금만 더 기다려 보아요.")
                    .foregroundColor(.theme.secondary)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(.top, 36)
            }
        }
    }
    
    func resultAlgorithm() -> (AttachmentType, Double, Double) {
        var evenData: Int32 = 0
        var oddData: Int32 = 0
        
        for i in 0...35 {
            if i % 2 == 0 {
                evenData += share[i].questionAnswer
                print("----> \(i)의 값 \(share[i].questionAnswer) 짝수 값 \(evenData)")
            } else {
                oddData += share[i].questionAnswer
                print("----> \(i)의 값 \(share[i].questionAnswer) 홀수 값 \(oddData)")
            }
        }
        
        // 회피 점수 및 불안 점수 계산
        let avoidantScore: Double = Double(oddData) / 18
        let anxiousScore: Double = Double(evenData) / 18
        print("----> 불안점수 : \(anxiousScore)")
        print("----> 회피점수 : \(avoidantScore)")
        
        // 각 점수를 5점 만점 -> 100점 만점 환산 (score * 20)
        let exchangedAvoidantScore: Double = avoidantScore * 20
        let exchangedAnxiousScore: Double = anxiousScore * 20
        
        print("----> 환산된 불안점수 : \(exchangedAnxiousScore)")
        print("----> 환산된 회피점수 : \(exchangedAvoidantScore)")
        
        // 유형 검사
        if avoidantScore < 2.33 {
            if anxiousScore < 2.61 {
                // 안정형
                return (.secure, exchangedAnxiousScore, exchangedAvoidantScore)
            } else {
                // 불안형
                return (.anxious, exchangedAnxiousScore, exchangedAvoidantScore)
            }
        } else {
            if anxiousScore < 2.61 {
                // 회피형
                return (.avoidant, exchangedAnxiousScore, exchangedAvoidantScore)
            } else {
                // 공포형
                return (.fearful, exchangedAnxiousScore, exchangedAvoidantScore)
            }
        }
    }
}

//struct LoverHome_Previews: PreviewProvider {
//    static var previews: some View {
//        LoverHome(week: .constant(6), currentIndex: .constant(5), current: .constant(5))
//    }
//}
