//
//  Equipos.swift
//  GDSolicitudes
//
//  Created by TI on 10/03/26.
//

import SwiftUI

struct Equipos: Codable, Identifiable {
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
}
