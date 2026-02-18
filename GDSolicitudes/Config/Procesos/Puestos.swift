//
//  Puestos.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Puestos: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let fechacad: FechaAPI
    let solicitante: String
    //Detalles RH
    let temp: Int
    let perid: Int
    let nom: String
    let areaact: Int
    let areasol: Int
    let areadescact: String
    let areadescsol: String
    let pueact: String
    let puesol: String
    let puedescact: String
    let puedescsol: String
    let catact: String
    let catsol: String
    let catdescact: String
    let catdescsol: String
    let fectempini: FechaAPI?
    let fectempfin: FechaAPI?
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
    let emp: Int
    let cns: Int
    let uuid: String
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case prodescripcion = "ProcesoDescripcion"
        case fechacad = "FechaCaducidad"
        case solicitante = "SolicitanteNombre"
        //Detalles RH
        case temp = "SolicitudTemporal"
        case perid = "PersonalID"
        case nom = "Nombres"
        case areaact = "AreaActual"
        case areasol = "AreaSolicitado"
        case areadescact = "AreaDescripcionActual"
        case areadescsol = "AreaDescripcionSolicitado"
        case pueact = "PuestoActual"
        case puesol = "PuestoSolicitado"
        case puedescact = "PuestoDescripcionActual"
        case puedescsol = "PuestoDescripcionSolicitado"
        case catact = "CategoriaDelPersonalIDActual"
        case catsol = "CategoriaDelPersonalIDSolicitado"
        case catdescact = "CategoriaDelPersonalIDDescripcionActual"
        case catdescsol = "CategoriaDelPersonalIDDescripcionSolicitado"
        case fectempini = "FechaTemporalInicial"
        case fectempfin = "FechaTemporalFinal"
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
                case .mil: return "Gas-Milenium"
                case .nan: return "Vendogas-Nanchital"
                case .tri: return "Vendogas-Trinitaria"
                case .tda: return "Transportes-D'Amiano"
                case .gen: return "Stargas"
                case .pac: return "Vendogas-del-Pacifico"
                case .pmil: return "Pacifico-Milenium"
                }
            }
        }
        let idBusqueda = emp
        return Empresa(rawValue: idBusqueda)?.siglas ?? "Desconocida"
    }
    var datosAux: String {
        let info = "\(nomEmp)--\(procesoid)--\(solicitud)--\(cns)"
        return info
    }
    var urlAutorizar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudDesbloqueoUpd/2/-/\(datosAux)"
        return URL(string: urlString)
    }
    var urlRechazar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudDesbloqueoUpd/3/"
        return URL(string: urlString)
    }
}
