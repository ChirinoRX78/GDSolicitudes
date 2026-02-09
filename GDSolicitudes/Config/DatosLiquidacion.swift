//
//  DatosLiquidacion.swift
//  TestWF
//
//  Created by TI on 21/01/26.
//

struct DatosLiquidacion: Codable, Identifiable {
    let id: Int
    let fecha: FechaAPI
    let serie: String
    let folio: Int
    let solicitud: String
    let alm: String
    let veh: String
    let cliente: String
    let nom_cliente: String
    let contrato: Int
    let nom_contrato: String
    let cantidad: String
    let precio: String
    let total: String
    let tipo: Int
    let solicitante: String
    let comentarios: String
    enum CodingKeys: String, CodingKey {
        case id = "EmpresaID"
        case fecha = "FechaHora"
        case serie = "SerieTicket"
        case folio = "FolioTicket"
        case solicitud = "SolicitudDescripcion"
        case alm = "AlmacenID"
        case veh = "Vehiculo"
        case cliente = "Cliente"
        case nom_cliente = "Nombre"
        case contrato = "Contrato"
        case nom_contrato = "NombreContrato"
        case cantidad = "Cantidad"
        case precio = "Precio"
        case total = "Total"
        case tipo = "TipoSolicitud"
        case solicitante = "SolicitoNombre"
        case comentarios = "SolicitoComentarios"
    }
}
