//
//  Salarios.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Salarios: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let fechacad: FechaAPI
    let solicitante: String
    //Detalles RH
    let nom: String
    let perid: Int
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
    let suediaimact: String
    let suediaimsol: String
    let suediarealact: String
    let suediarealsol: String
    let suesemimact: String
    let suesemimsol: String
    let suesemrealact: String
    let suesemrealsol: String
    let suecatimact: String
    let suecatimsol: String
    let suecatrealact: String
    let suecatrealsol: String
    let suemenimact: String
    let suemenimsol: String
    let suemenrealact: String
    let suemenrealsol: String
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
        case nom = "Nombres"
        case per = "PersonalID"
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
        case suediaimact = "SueldoDiarioIMSSActual"
        case suediaimsol = "SueldoDiarioIMSSSolicitado"
        case suediarealact = "SueldoDiarioRealActual"
        case suediarealsol = "SueldoDiarioRealSolicitado"
        case suesemimact = "SueldoSemanalIMSSActual"
        case suesemimsol = "SueldoSemanalIMSSSolicitado"
        case suesemrealact = "SueldoSemanalRealActual"
        case suesemrealsol = "SueldoSemanalRealSolicitado"
        case suecatimact = "SueldoCatorcenalIMSSActual"
        case suecatimsol = "SueldoCatorcenalIMSSSolicitado"
        case suecatrealact = "SueldoCatorcenalRealActual"
        case suecatrealsol = "SueldoCatorcenalRealSolicitado"
        case suemenimact = "SueldoMensualIMSSActual"
        case suemenimsol = "SueldoMensualIMSSSolicitado"
        case suemenrealact = "SueldoMensualRealActual"
        case suemenrealsol = "SueldoMensualRealSolicitado"
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