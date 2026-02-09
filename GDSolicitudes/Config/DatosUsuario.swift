//
//  DatosUsuario.swift
//  TestWF
//
//  Created by TI on 15/01/26.
//

struct DatosUsuario: Codable {
    let name: String
    let emailAddress: String
    let nomenclaturaID: String
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case emailAddress = "EmailAddress"
        case nomenclaturaID = "NomenclaturaID"
    }
}
