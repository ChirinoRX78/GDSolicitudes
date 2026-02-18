//
//  Bajas.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Bajas: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let fechacad: FechaAPI
    let solicitante: String
    //Detalles RH
    let perid: Int
    let nom: String
    let monto: String
    let causa: String
    let causadesc: String
    let fechaing: FechaAPI
    let areaact: Int
    let areadescact: String
    let pueact: String
    let puedescact: String
    let catact: String
    let catdescact: String
    let permitir: Int
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
        case fechacad = "FechaCaducidad"
        case solicitante = "SolicitanteNombre"
        //Detalles RH
        case perid = "PersonalID"
        case nom = "Nombres"
        case monto = "MontoPagado"
        case causa = "CausaBaja"
        case causadesc = "CausaBajaDescripcion"
        case fechaing = "FechaIngreso"
        case areaact = "Area"
        case areadescact = "AreaDescripcion"
        case pueact = "Puesto"
        case puedescact = "PuestoDescripcion"
        case catact = "CategoriaDelPersonalID"
        case catdescact = "CategoriaDelPersonalIDDescripcion"
        case permitir = "PermitirRecontratar"
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
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudPersonalBajasUpd/\(autoriza)/2/-/\(datosAux)"
        return URL(string: urlString)
    }
    var urlRechazar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudPersonalBajasUpd/\(autoriza)/3/"
        return URL(string: urlString)
    }
}
