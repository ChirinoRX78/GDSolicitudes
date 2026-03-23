//
//  Equipos.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct Equipos: Codable, Identifiable {
    let id = UUID()
    let equipo: Int
    let nomequipo: String
    let serie: String
    let fechaentr: FechaAPI
    let fechainst: FechaAPI
    let cap: String
    enum CodingKeys: String, CodingKey {
        case equipo = "EquipoSolicitado"
        case nomequipo = "DescripcionSolicitado"
        case serie = "SerieSolicitado"
        case fechaentr = "FechaEntregaSolicitado"
        case fechainst = "FechaInstalacionSolicitado"
        case cap = "CapacidadSolicitado"
    }
}
