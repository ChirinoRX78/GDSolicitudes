//
//  Roles.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct Roles: Codable, Identifiable {
    let id = UUID()
    let solicitud: Int
    let personal: Int
    let tipo: String
    let funcion: String
    let asignar: Int
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case personal = "PersonalID"
        case tipo = "Tipo"
        case funcion = "Funcion"
        case asignar = "Asignar"
    }
}
