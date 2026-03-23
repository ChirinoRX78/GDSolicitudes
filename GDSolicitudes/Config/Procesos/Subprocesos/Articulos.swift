//
//  Articulos.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct Articulos: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let articulo: Int
    let nomarticulo: String
    let cns: Int
    let cant: String
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case articulo = "ArticuloID"
        case nomarticulo = "Articulo"
        case cns = "PartidaID"
        case cant = "CantidadEntregada"
    }
}
