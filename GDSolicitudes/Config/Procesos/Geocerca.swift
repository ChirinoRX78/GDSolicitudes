//
//  Geocerca.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Geocerca: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let cliente: Int
    let nom_cliente: String
    let contrato: Int
    let nom_contrato: String
    let latact: String
    let lonact: String
    let radact: Int
    let latsol: String
    let lonsol: String
    let radsol: Int
    let singeodefact: Int
    let singeodefsol: Int
    let singeotempact: Int
    let singeotempsol: Int
    let singeotempdesde: FechaAPI
    let singeotemphasta: FechaAPI
    let geobloq: Int
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
    let emp: Int
    let cns: Int
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case prodescripcion = "ProcesoDescripcion"
        case cliente = "ClienteID"
        case nom_cliente = "NombreCliente"
        case contrato = "ContratoID"
        case nom_contrato = "NombreContrato"
        case latact = "LatitudActual"
        case lonact = "LongitudActual"
        case radact = "RadioActual"
        case latsol = "LatitudSolicitado"
        case lonsol = "LongitudSolicitado"
        case radsol = "RadioSolicitado"
        case singeodefact = "TrabajarSinGeocercaDefinitivoActual"
        case singeodefsol = "TrabajarSinGeocercaDefinitivoSolicitado"
        case singeotempact = "SinGeocercaTemporalActual"
        case singeotempsol = "SinGeocercaTemporalSolicitado"
        case singeotempdesde = "SinGeocercaTemporalSolicitadoDesde"
        case singeotemphasta = "SinGeocercaTemporalSolicitadoHasta"
        case geobloq = "BloquearConGeocerca"
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
        case emp = "EmpresaID"
        case cns = "Cns"
    }
    var nomEmp: String {
        enum Empresa: Int {
            case dam = 1
            case tab = 2
            case ven = 3
            case mil = 4
            case nan = 5
            case tri = 7
            case tda = 8
            case gen = 12
            case pac = 14
            case pmil = 37
            var siglas: String {
                switch self {
                case .dam: return "Damigas"
                case .tab: return "Tabagas"
                case .ven: return "Vendogas"
                case .mil: return "Gas Milenium"
                case .nan: return "Vendogas Nanchital"
                case .tri: return "Vendogas Trinitaria"
                case .tda: return "Transportes D'Amiano"
                case .gen: return "Stargas"
                case .pac: return "Vendogas del Pacifico"
                case .pmil: return "Pacifico Milenium"
                }
            }
        }
        let idBusqueda = emp
        return Empresa(rawValue: idBusqueda)?.siglas ?? "Desconocida"
    }
    var datosAux: String {
        let info = "\(nomEmp)--\(procesoid)--\(solicitud)--\(cns)"
        return info//.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? info
    }
    var urlAutorizar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudGeocercaAContratoUpd/\(autoriza)/2/-/\(datosAux)"
        return URL(string: urlString)
    }
    var urlRechazar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudGeocercaAContratoUpd/\(autoriza)/3/"
        return URL(string: urlString)
    }
}
