//
//  Envelope.swift
//  MC2-Team7-Fighring
//
//  Created by 이용준의 Macbook on 2023/05/10.
//

import Foundation

struct Item_envelope: Identifiable {
    var id: Int
    var envelope: String
}

class EnvelopeStore: ObservableObject {
    @Published var items: [Item_envelope]
    
    let envelopes: [String] = ["envelope1", "envelope2", "envelope3", "envelope4", "envelope5", "envelope6"]
    
    // dummy data
    init() {
        items = []
        for i in 0...5 {
            let new = Item_envelope(id: i, envelope: envelopes[i])
            items.append(new)
        }
    }
}
