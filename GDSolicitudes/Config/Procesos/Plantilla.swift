//
//  Plantilla.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Plantilla: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let fechacad: FechaAPI
    let solicitante: String
    //Datos RH
    let nuevo: Int
    let numplazadis: Int
    let numplazaaum: Int
    let otros: Int
    let numplazaact: Int
    let numplazasol: Int
    let plantillaact: Int
    let plantillasol: Int
    let tempact: Int
    let tempsol: Int
    let fechatempini: FechaAPI
    let fechatempfin: FechaAPI
    let puesto: Int
    let puestodescact: String
    let puestodescsol: String
    let puestodescactlarga: String
    let puestodescsollarga: String
    let areact: String
    let aresol: String
    let areadescact: String
    let areadescsol: String
    let puestopadreact: Int
    let puestopadresol: Int
    let puestopadredescact: String
    let puestopadredescsol: String
    let edadminact: Int
    let edadminsol: Int
    let edadmaxact: Int
    let edadmaxsol: Int
    let sexoact: String
    let sexosol: String
    let sexodescact: String
    let sexodescsol: String
    let civilact: String
    let civilsol: String
    let civildescact: String
    let civildescsol: String
    let escact: Int
    let escsol: Int
    let escdescact: String
    let escdescsol: String
    let otrosact: String
    let otrossol: String
    let riesgoact: String
    let riesgosol: String
    let riesgodescact: String
    let riesgodescsol: String
    let puestoimact: Int
    let puestoimsol: Int
    let puestoimmdescact: String
    let puestoimmdescsol: String
    let cattipodescact: String
    let cattipodescsol: String
    let cattipodescdescact: String
    let cattipodescdescsol: String
    let objact: String
    let objsol: String
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
        //Datos RH
        case nuevo = "NuevoPuesto"
        case numplazadis = "NumeroDePlazaDisminuye"
        case numplazaaum = "NumeroDePlazaAumenta"
        case otros = "OtrosCampos"
        case numplazaact = "NumeroDePlazasActual"
        case numplazasol = "NumeroDePlazasSolicitado"
        case plantillaact = "PlantillaTotalActual"
        case plantillasol = "PlantillaTotalSolicitado"
        case tempact = "PuestoTemporalActual"
        case tempsol = "PuestoTemporalSolicitado"
        case fechatempini = "FechaTemporalInicial"
        case fechatempfin = "FechaTemporalFinal"
        case puesto = "PuestoID"
        case puestodescact = "DescripcionCortaActual"
        case puestodescsol = "DescripcionCortaSolicitado"
        case puestodescactlarga = "DescripcionLargaActual"
        case puestodescsollarga = "DescripcionLargaSolicitado"
        case areact = "AreaActual"
        case aresol = "AreaSolicitado"
        case areadescact = "AreaDescripcionActual"
        case areadescsol = "AreaDescripcionSolicitado"
        case puestopadreact = "PuestoPadreActual"
        case puestopadresol = "PuestoPadreSolicitado"
        case puestopadredescact = "PuestoPadreDescripcionActual"
        case puestopadredescsol = "PuestoPadreDescripcionSolicitado"
        case edadminact = "EdadMinimaActual"
        case edadminsol = "EdadMinimaSolicitado"
        case edadmaxact = "EdadMaximaActual"
        case edadmaxsol = "EdadMaximaSolicitado"
        case sexoact = "SexoActual"
        case sexosol = "SexoSolicitado"
        case sexodescact = "SexoDescripcionActual"
        case sexodescsol = "SexoDescripcionSolicitado"
        case civilact = "EstadoCivilActual"
        case civilsol = "EstadoCivilSolicitado"
        case civildescact = "EstadoCivilDescripcionActual"
        case civildescsol = "EstadoCivilDescripcionSolicitado"
        case escact = "NivelEscolaridadActual"
        case escsol = "NivelEscolaridadSolicitado"
        case escdescact = "NivelEscolaridadDescripcionActual"
        case escdescsol = "NivelEscolaridadDescripcionSolicitado"
        case otrosact = "OtrosEstudiosActual"
        case otrossol = "OtrosEstudiosSolicitado"
        case riesgoact = "RiesgoPuestoActual"
        case riesgosol = "RiesgoPuestoSolicitado"
        case riesgodescact = "RiesgoPuestoDescripcionActual"
        case riesgodescsol = "RiesgoPuestoDescripcionSolicitado"
        case puestoimact = "PuestoIdIMSSActual"
        case puestoimsol = "PuestoIdIMSSSolicitado"
        case puestoimmdescact = "PuestoIdIMSSDescripcionActual"
        case puestoimmdescsol = "PuestoIdIMSSDescripcionSolicitado"
        case cattipodescact = "CategoriaTiposDePersonalActual"
        case cattipodescsol = "CategoriaTiposDePersonalSolicitado"
        case cattipodescdescact = "CategoriaTiposDePersonalDescripcionActual"
        case cattipodescdescsol = "CategoriaTiposDePersonalDescripcionSolicitado"
        case objact = "ObjetivoGeneralActual"
        case objsol = "ObjetivoGeneralSolicitado"
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
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudPuestosUpd/\(autoriza)/2/-/\(datosAux)"
        return URL(string: urlString)
    }
    var urlRechazar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudPuestosUpd/\(autoriza)/3/"
        return URL(string: urlString)
    }
}
