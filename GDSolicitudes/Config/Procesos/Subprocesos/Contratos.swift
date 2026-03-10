//
//  Contratos.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct Contratos: Codable, Identifiable {
    let id = UUID()
    let contrato: Int
    let nombre: String
    let tipo: Int
    let tipodesc: String
    let tipopre: Int
    let tipopredesc: String
    let precio: String
    let venta: String
    enum CodingKeys: String, CodingKey {
        case contrato = "ContratoID"
        case nombre = "Nombre"
        case tipo = "TipoContrato"
        case tipodesc = "TipoContratoDescripcion"
        case tipopre = "TipoPrecio"
        case tipopredesc = "TipoPrecioDescripcion"
        case precio = "PercioActual"
        case venta = "TipoVenta"
    }
}
