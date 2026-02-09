//
//  PreferencesView.swift
//  TestWF
//
//  Created by TI on 09/01/26.
//

import SwiftUI

struct PreferencesView: View {
    static let tiempoEspera = "tiempoEspera"
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
// Función para obtener versión de la aplicación
// Para cambiarla ir a TestWF / Identity / Version
extension Bundle {
    var appVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
