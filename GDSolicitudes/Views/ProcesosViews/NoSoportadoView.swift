//
//  NoSoportado.swift
//  TestWF
//
//  Created by TI on 04/02/26.
//

import SwiftUI
import Foundation

struct NoSoportadoView: View {
    let procesoID: Int
    let solicitudID: Int

    var body: some View {
        VStack(spacing: 12) {
            Text("Proceso en construcción")
                .font(.title2).bold()
            Text("ProcesoID: \(procesoID)")
            Text(verbatim: "SolicitudID: \(solicitudID)")
        }
        .padding()
    }
}
