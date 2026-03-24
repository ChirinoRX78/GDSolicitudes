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
    //Descuento
    let articulo: Int
    let nomarticulo: String
    let descact: String
    let descsol: String
    let descltr: String
    let descautact: Int
    let descautsol: Int
    //Crédito
    let diasact: Int
    let diassol: Int
    let limact: String
    let limsol: String
    let ctaact: String
    let nomctaact: String
    let ctasol: String
    let nomctasol: String
    //Precio
    let preact: Int
    let preactdesc: String
    let presol: Int
    let presoldesc: String
    //Desbloqueo
    let fecini: FechaAPI
    let fecfin: FechaAPI
    //Geocerca
    let latact: String
    let lonact: String
    let radact: Int
    let latsol: String
    let lonsol: String
    let radsol: Int
    let geopermact: Int
    let geopermsol: Int
    let geotempact: Int
    let geotempsol: Int
    let geotempfecdesde: FechaAPI
    let geotempfechasta: FechaAPI
    let geobloq: Int
    //Detalles generales
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
        //Descuento
        case articulo = "ArticuloID"
        case nomarticulo = "ArticuloNombre"
        case descact = "DescuentoActual"
        case descsol = "DescuentoSolicitado"
        case descltr = "DescuentoPorLitro"
        case descautact = "DescuentoAutomaticoActual"
        case descautsol = "DescuentoAutomaticoSolicitado"
        //Crédito
        case diasact = "DiasCredito"
        case diassol = "DiasCreditoSolicitado"
        case limact = "LimiteCredito" 
        case limsol = "LimiteCreditoSolicitado"
        case ctaact = "CuentaContable"
        case nomctaact = "CuentaContableNombre"
        case ctasol = "CuentaContableSolicitado"
        case nomctasol = "CuentaContableSolicitadoNombreCuenta"
        //Precio
        case preact = "TipoPrecioActual"
        case preactdesc = "TipoPrecioActualDescripcion"
        case presol = "TipoPrecioSolicitado"
        case presoldesc = "TipoPrecioSolicitadoDescripcion"
        //Desbloqueo
        case fecini = "FechaInicialDesbloqueoSolicitado"
        case fecfin = "FechaFinalDesbloqueoSolicitado"
        //Geocera
        case latact = "LatitudActual"
        case lonact = "LongitudActual"
        case radact = "RadioActual"
        case latsol = "LatitudSolicitado"
        case lonsol = "LongitudSolicitado"
        case radsol = "RadioSolicitado"
        case geopermact = "TrabajarSinGeocercaDefinitivoActual"
        case geopermsol = "TrabajarSinGeocercaDefinitivoSolicitado"
        case geotempact = "SinGeocercaTemporalActual"
        case geotempsol = "SinGeocercaTemporalSolicitado"
        case geotempfecdesde = "SinGeocercaTemporalSolicitadoDesde"
        case geotempfechasta = "SinGeocercaTemporalSolicitadoHasta"
        case geobloq = "BloquearConGeocerca"
        //Detalles generales
        case saldo = "SaldoTotal"
        case saldoven = "SaldoVencido"
        case ultpago = "UltimoPagoMonto"
        case ultpagofecha = "UltimoPagoFecha"
        case solicitante = "SolicitanteNombre"
    }
}
