//
//  ArchivosView.swift
//  GDSolicitudes
//
//  Created by TI on 26/02/26.
//

import SwiftUI
import Foundation

struct ArchivosView: View {
    let archivos: [Archivo]
    @State private var archivoURL: URL?
    @State private var mostrarPreview = false
    @State private var errorMsg: String?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView{
            List(archivos) { archivo in
                Button {
                    //abrirArchivo(archivo)
                    if let url = ArchivoHelper.guardarArchivoTemporal(
                                nombre: archivo.ArchivoNombre,
                                base64: archivo.Archivo
                            ) {
                                archivoURL = url
                            }
                } label: {
                    HStack{
                        Image(systemName: iconoParaArchivo(archivo.ArchivoNombre))
                            .foregroundColor(Color("Blue1"))
                        Text(archivo.ArchivoNombre)
                            .font(.system(size: 16))
                    }
                }
            }
            .navigationTitle("Archivos adjuntos")
            .navigationBarTitleDisplayMode(.inline)
            /*.sheet(isPresented: $mostrarPreview) {
                if let url = archivoURL {
                    PreviewController(url: url)
                }
            }*/
            .sheet(item: $archivoURL) { url in
                PreviewController(url: url)
            }
            .alert("Error", isPresented: Binding(
                get: { errorMsg != nil },
                set: { _ in errorMsg = nil }
            )) {
                Button("Aceptar", role: .cancel) {}
            } message: {
                Text(errorMsg ?? "")
            }
            /*
            .padding(.top, -20)
            .navigationTitle("Archivos adjuntos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("Blue1"))
                        .padding(.top, 10)
                        .padding(.trailing, 20)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Archivos adjuntos")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("Blue1"))
                        .padding(.top, 10)
                }
            }*/
        }
    }
    func iconoParaArchivo(_ nombre: String) -> String {
        if nombre.lowercased().hasSuffix(".pdf") { return "doc.richtext.fill" }
        if nombre.lowercased().hasSuffix(".jpg") { return "photo.fill" }
        if nombre.lowercased().hasSuffix(".png") { return "photo.fill" }
        if nombre.lowercased().hasSuffix(".xlsx") { return "tablecells.fill" }
        if nombre.lowercased().hasSuffix(".docx") { return "doc.text.fill" }
        return "doc.fill"
    }
    /*private func abrirArchivo(_ archivo: Archivo) {
        do {
            let url = try guardarArchivoTemporal(
                nombre: archivo.ArchivoNombre,
                base64: archivo.Archivo
            )
            archivoURL = url
            mostrarPreview = true
        } catch {
            errorMsg = "No se pudo abrir el archivo."
        }
    }*/
}
extension URL: Identifiable {
    public var id: String { absoluteString }
}
