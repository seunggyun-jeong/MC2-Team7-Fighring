//
//  Envelope.swift
//  MC2-Team7-Fighring
//
//  Created by 이용준의 Macbook on 2023/05/10.
//

import SwiftUI
import Combine

struct Envelope: Identifiable{
    var id = UUID().uuidString
    var envelopeImage: String
}

class EnvelopeIndex: ObservableObject {
    @Published var week: Int = Int(UserDefaults.standard.string(forKey: "week") ?? "0") ?? 0
    @Published var currentIndex_home: Int = ( Int(UserDefaults.standard.string(forKey: "week") ?? "-1" )! ) - 1
    @Published var currentIndex_view: Int = ( Int(UserDefaults.standard.string(forKey: "week") ?? "-1" )! ) - 1
}
