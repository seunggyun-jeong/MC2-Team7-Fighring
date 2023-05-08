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
    
    var body: some View {
        if isConfirm {
            LoadingView()
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
