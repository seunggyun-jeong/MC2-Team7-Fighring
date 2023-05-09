//
//  CodeShare.swift
//  MC2-Team7-Fighring
//
//  Created by 정도현 on 2023/05/09.
//

import SwiftUI

// 공유기능
struct ActivityViewController: UIViewControllerRepresentable {
    // 실제 공유되는 값.
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        // activityItems: 실제로 공유하기에서 복사되는 값, applicationActivities: 공유 어플 지정.
        return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Do nothing
    }
}
