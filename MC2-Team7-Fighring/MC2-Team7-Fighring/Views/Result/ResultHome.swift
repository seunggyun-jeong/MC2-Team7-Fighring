//
//  ResultHome.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct ResultHome: View {
    @State private var isLocked: Bool = !(UserDefaults.standard.bool(forKey: "isAllComplete"))
//    @State private var isLocked: Bool = false
    @State private var isConfirm: Bool = false
    @State private var isLoadingDone: Bool = false
    @State private var isGetResult: Bool = UserDefaults.standard.bool(forKey: "isGetResult")
//    @State private var isGetResult: Bool = false
    
    var body: some View {
        if isGetResult {
            TestMain()
        } else {
            if isConfirm {
                if isLoadingDone {
                    MyResultSheet(isGetResult: $isGetResult, showTypeSheet: .constant(false))
                } else {
                    LoadingView(isLoadingDone: $isLoadingDone)
                }
            } else {
                LockedResult(isLocked: isLocked, isConfirm: $isConfirm)
                    .onAppear {
                        isLocked = !(UserDefaults.standard.bool(forKey: "isAllComplete"))
                    }
            }
        }
    }
}

struct ResultHome_Previews: PreviewProvider {
    static var previews: some View {
        ResultHome()
    }
}
