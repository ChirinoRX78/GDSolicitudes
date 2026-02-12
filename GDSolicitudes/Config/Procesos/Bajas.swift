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
    let areaact: String
    let areasol: String
    let areadescact: String
    let areadescsol: String
    let pueact: Int
    let puesol: Int
    let puedescact: String
    let puedescsol: String
    let catact: String
    let catsol: String
    let catdescact: String
    let catdescsol: String
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
        case areaact = "AreaActual"
        case areasol = "AreaDescripcionActual"
        case areadescact = "AreaSolicitado"
        case areadescsol = "AreaDescripcionSolicitado"
        case pueact = "PuestoActual"
        case puesol = "PuestoDescripcionActual"
        case puedescact = "PuestoSolicitado"
        case puedescsol = "PuestoDescripcionSolicitado"
        case catact = "CategoriaDelPersonalIDActual"
        case catsol = "CategoriaDelPersonalIDDescripcionActual"
        case catdescact = "CategoriaDelPersonalIDSolicitado"
        case catdescsol = "CategoriaDelPersonalIDDescripcionSolicitado"
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
    }
}