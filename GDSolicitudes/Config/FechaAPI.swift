//
//  FechaAPI.swift
//  TestWF
//
//  Created by TI on 21/01/26.
//

struct FechaAPI: Codable {
    let date: String
    enum CodingKeys: String, CodingKey {
        case date
    }
}
