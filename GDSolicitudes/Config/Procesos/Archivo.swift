//
//  Archivo.swift
//  GDSolicitudes
//
//  Created by TI on 23/02/26.
//

import SwiftUI

struct Archivo: Codable, Identifiable {
    let id = UUID()
    let SolicitudID: Int
    let ArchivoNombre: String
    let Archivo: String
    enum CodingKeys: String, CodingKey {
        case SolicitudID = "SolicitudID"
        case ArchivoNombre = "ArchivoNombre"
        case Archivo = "Archivo"
    }
}
