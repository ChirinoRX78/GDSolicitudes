//
//  DatosWorkflow.swift
//  TestWF
//
//  Created by TI on 21/01/26.
//

struct DatosWorkflow: Codable, Identifiable {
    let id: Int
    let empresaid: Int
    let descripcion: String
    let solicitanteID: String
    let fechaAlta: FechaAPI
    let procesoId: Int
    enum CodingKeys: String, CodingKey {
        case id = "SolicitudID"
        case empresaid = "EmpresaID"
        case descripcion = "Descripcion"
        case solicitanteID = "SolicitanteID"
        case fechaAlta = "FechaAlta"
        case procesoId = "ProcesoID"
    }
}
