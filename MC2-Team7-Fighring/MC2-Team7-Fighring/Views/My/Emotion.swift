//
//  Emotion.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/09.
//

import Foundation

struct Item: Identifiable {
    var id: Int
    var emotion: String
}

class EmotionStore: ObservableObject {
    @Published var items: [Item]
    
    let emotions: [String] = ["happy", "angry", "sad", "sulk", "brain fade"]
    
    // dummy data
    init() {
        items = []
        for i in 0...4 {
            let new = Item(id: i, emotion: emotions[i])
            items.append(new)
        }
    }
}
