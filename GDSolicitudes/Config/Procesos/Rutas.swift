//
//  Rutas.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Rutas: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let almacen: String
    let nom_almacen: String
    let ruta: Int
    let vehiculo: Int
    let numeco: String
    let fecha: FechaAPI
    let chofer: Int
    let chofernombre: String
    let tiporuta: String
    let estatus: String
    let fechacad: FechaAPI
    let solicitante: String
    //Detalles de la solicitud
    let nivel: Int
    let autoriza: String
    let fechasol: FechaAPI
    let sla: Int
    let fechasla: FechaAPI
    let motivo: Int
    let motivodesc: String
    let motivodetalle: String
    //Proceso
    let procesoid: Int
    let uuid: String
    let emp: Int
    let cns: Int
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case prodescripcion = "ProcesoDescripcion"
        case almacen = "AlmacenID"
        case nom_almacen = "NombreAlmacen"
        case ruta = "FolioID"
        case vehiculo = "VehiculoID"
        case numeco = "NumeroEconomicoVehiculo"
        case fecha = "Fecha"
        case chofer = "ChoferID"
        case chofernombre = "NombreChofer"
        case tiporuta = "RutaDistribucion"
        case estatus = "NombreEstatus"
        case fechacad = "FechaCaducidad"
        case solicitante = "SolicitanteNombre"
        //Detalles de la solicitud
        case nivel = "SecuenciaAutorizacion"
        case autoriza = "QuienAutoriza"
        case fechasol = "FechaAlta"
        case sla = "SLA"
        case fechasla = "FechaFinSLA"
        case motivo = "MotivoID"
        case motivodesc = "MotivoDescripcion"
        case motivodetalle = "MotivoDetalle"
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
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudRutasDistribucionUpd/\(autoriza)/2/-/\(datosAux)"
        return URL(string: urlString)
    }
    var urlRechazar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudRutasDistribucionUpd/\(autoriza)/3/"
        return URL(string: urlString)
    }
}
