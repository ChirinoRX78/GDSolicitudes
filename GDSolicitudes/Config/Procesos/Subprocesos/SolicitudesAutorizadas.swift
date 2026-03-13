//
//  SolicitudesAutorizadas.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct SolicitudesAutorizadas: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let fechaaut: FechaAPI
    let cliente: Int
    let nomcliente: String
    let contrato: Int
    let nomcontrato: String
    //Desbloqueo
    let fecini: FechaAPI
    let fecfin: FechaAPI
    let saldo: String
    let saldoven: String
    let ultpago: String
    let ultpagofecha: FechaAPI
    let solicitante: String
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case fechaaut = "FechaUltimaActualizacion"
        case cliente = "ClienteID"
        case nomcliente = "NombreCliente"
        case contrato = "ContratoID"
        case nomcontrato = "NombreContrato"
        //Desbloqueo
        case fecini = "FechaInicialDesbloqueoSolicitado"
        case fecfin = "FechaFinalDesbloqueoSolicitado"
        case saldo = "SaldoTotal"
        case saldoven = "SaldoVencido"
        case ultpago = "UltimoPagoMonto"
        case ultpagofecha = "UltimoPagoFecha"
        case solicitante = "SolicitanteNombre"
    }
}
