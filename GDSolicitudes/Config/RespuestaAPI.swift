//
//  RespuestaAPI.swift
//  TestWF
//
//  Created by TI on 21/01/26.
//

struct RespuestaAPI: Codable {
    let data: [DatosUsuario]
    let workflow: [String: DatosWorkflow]
    let liquidacion: [String: DatosLiquidacion]
}
