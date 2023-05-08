//
//  ResultHome.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/07.
//

import SwiftUI

struct ResultHome: View {
    @State private var isLocked: Bool = false
    @State private var isConfirm: Bool = false
    @State private var isLoadingDone: Bool = false
    @State private var is36DaysLater: Bool = false
    
    var body: some View {
        if isConfirm {
            if isLoadingDone {
                if is36DaysLater {
                    TestMain()
                } else {
                    MyResultSheet(is36DaysLater: $is36DaysLater)
                }
            } else {
                LoadingView(isLoadingDone: $isLoadingDone)
            }
        } else {
            LockedResult(isLocked: isLocked, isConfirm: $isConfirm)
        }
    }
}

struct ResultHome_Previews: PreviewProvider {
    static var previews: some View {
        ResultHome()
    }
}
