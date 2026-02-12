//
//  Descuento.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Descuento: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let cliente: Int
    let nom_cliente: String
    let articulo: Int
    let articulodesc: String
    let descuentoact: String
    let descuentosol: String
    let descuentoxltr: String
    let descuentoautact: Int
    let descuentoautsol: Int
    let saldo: String
    let saldovencido: String
    let ultpagofecha: FechaAPI
    let ultpago: String
    let fechacad: FechaAPI
    let solicitante: String
    //Detalles de la solicitud
    let nivel: Int
    let autoriza: String
    let fechasol: FechaAPI
    let sla: Int
    let fechasla: FechaAPI
    let diascredito: Int
    let limcredito: String
    let diasven: Int
    let cuenta: String
    let nom_cuenta: String?
    let motivo: Int
    let motivodesc: String
    let motivodetalle: String
    let comp: Int
    let compdesc: String
    let compdetalle: String
    let compfecha: FechaAPI
    let monto: String
    //Proceso
    let procesoid: Int
    let uuid: String
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case prodescripcion = "ProcesoDescripcion"
        case cliente = "ClienteID"
        case nom_cliente = "NombreCliente"
        case articulo = "ArticuloID"
        case articulodesc = "ArticuloNombre"
        case descuentoact = "DescuentoActual"
        case descuentosol = "DescuentoSolicitado"
        case descuentoxltr = "DescuentoPorLitro"
        case descuentoautact = "DescuentoAutomaticoActual"
        case descuentoautsol = "DescuentoAutomaticoSolicitado"
        case saldo = "SaldoTotal"
        case saldovencido = "SaldoVencido"
        case ultpagofecha = "UltimoPagoFecha"
        case ultpago = "UltimoPagoMonto"
        case fechacad = "FechaCaducidad"
        case solicitante = "SolicitanteNombre"
        //Detalles de la solicitud
        case nivel = "SecuenciaAutorizacion"
        case autoriza = "QuienAutoriza"
        case fechasol = "FechaAlta"
        case sla = "SLA"
        case fechasla = "FechaFinSLA"
        case diascredito = "DiasCredito"
        case limcredito = "LimiteCredito"
        case diasven = "DiasVencidos"
        case cuenta = "CuentaContable"
        case nom_cuenta = "CuentaContableNombre"
        case motivo = "MotivoID"
        case motivodesc = "MotivoDescripcion"
        case motivodetalle = "MotivoDetalle"
        case comp = "CompromisoID"
        case compdesc = "CompromisoDescripcion"
        case compdetalle = "CompromisoDetalle"
        case compfecha = "CompromisoFecha"
        case monto = "CompromisoValor"
        //Proceso
        case procesoid = "ProcesoID"
        case uuid = "New_ID"
    }
}
