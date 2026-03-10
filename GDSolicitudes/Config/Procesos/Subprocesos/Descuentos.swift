//
//  Descuentos.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct Descuentos: Codable, Identifiable {
    let id = UUID()
    let articulo: Int
    let desc: String
    let descuento: String
    let tipo: String
    let auto: Int
    enum CodingKeys: String, CodingKey {
        case articulo = "ArticuloID"
        case desc = "Corta"
        case descuento = "Descuento"
        case tipo = "Tipo"
        case auto = "Automatico"
    }
}
