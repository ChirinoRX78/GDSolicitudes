//
//  ArchivoHelper.swift
//  GDSolicitudes
//
//  Created by TI on 27/02/26.
//

import Foundation

struct ArchivoHelper {
    static func guardarArchivoTemporal(nombre: String, base64: String) -> URL? {
        print("📄 Intentando guardar archivo:", nombre)
        print("📦 Base64 longitud:", base64.count)
        guard let data = Data(base64Encoded: base64) else {
            print("❌ No se pudo convertir Base64")
            return nil
        }
        print("✅ Data creada. Tamaño en bytes:", data.count)
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(nombre)
        print("📁 Ruta temporal:", tempURL)
        do {
            try data.write(to: tempURL)
            print("✅ Archivo guardado correctamente")
            return tempURL
        } catch {
            print("❌ Error al guardar archivo:", error)
            return nil
        }
    }
}
