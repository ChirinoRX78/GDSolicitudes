//
//  LoaderView.swift
//  TestWF
//
//  Created by TI on 26/01/26.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            LottieView(name: "cargando", loopMode: .loop)
                .frame(width: 100, height: 100)
        }
    }
}
