//
//  Ex+Color.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/10.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let mainColor = Color("mainColor")
    let secondary = Color("secondary")
    let detailButton = Color("DetailButton")
    let detailTextField = Color("DetailTextField")
    let teritary = Color("teritiary")
}
