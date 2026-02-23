struct RespuestaArchivo: Codable {
    let data: [DatosAdjunto]
}

struct DatosAdjunto: Codable, Identifiable {
    let id = UUID()
    let SolicitudID: Int
    let ArchivoNombre: String
    let Archivo: String
}
