//
//  Facturas.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct Facturas: Codable, Identifiable {
    let id = UUID()
    let concepto: String
    let folio: Int
    let fecha: FechaAPI
    let fechaven: FechaAPI
    let cargo: String
    let abono: String
    let saldo: String
    let s7d: String
    let s15d: String
    let s30d: String
    let s60d: String
    let sano: String
    let smano: String
    let vencido: String
    enum CodingKeys: String, CodingKey {
        case concepto = "ConceptoID"
        case folio = "FolioID"
        case fecha = "Fecha"
        case fechaven = "FechaVencimiento"
        case cargo = "Cargo"
        case abono = "Abono"
        case saldo = "Saldo"
        case s7d = "s7D"
        case s15d = "s15D"
        case s30d = "s30D"
        case s60d = "s60D"
        case sano = "s1AÑO"
        case smano = "sM1AÑO"
        case vencido = "Vencido"
    }
}
