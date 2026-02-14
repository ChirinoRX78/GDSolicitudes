//
//  LoaderLoginView.swift
//  TestWF
//
//  Created by TI on 26/01/26.
//

import SwiftUI

struct LoaderLoginView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 160, height: 160)
                .ignoresSafeArea()
            LottieView(name: "cargando", loopMode: .loop)
                .frame(width: 350, height: 350)
        }
    }
}
