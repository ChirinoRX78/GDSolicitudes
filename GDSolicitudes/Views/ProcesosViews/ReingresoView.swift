//
//  ReingresoView.swift
//  TestWF
//
//  Created by TI on 04/02/26.
//

import SwiftUI
import Foundation

struct ReingresoView: View {
    @Environment(\.dismiss) private var dismiss
    let solicitudID: Int
    @State private var cargando = true
    @State private var errorMsg: String? = nil
    @State private var datos: [Reingresos] = []
    @State private var mostrandoLoader = false
    @State private var mostrarAlerta = false
    @State private var mensajeAlerta = ""
    @State private var confirmarAccion = false
    @State private var urlSeleccionada: URL?
    @State private var accionTexto = ""
    @State private var procesando = false
    @State private var accionPendiente: Accion? = nil
    @State private var urlPendiente: URL? = nil
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color("WhiteBG")
                    .ignoresSafeArea()
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color("Blue1"))
                        .frame(height: geo.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                }
                //MARK: Header
                HStack(spacing: 0) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .padding(.leading, 30)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Text("Detalles")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                    Spacer()
                    Button(action: {
                        //
                    }) {
                        Image(systemName: "paperclip")
                            .foregroundColor(.white)
                            .padding(.leading, 30)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                        .frame(width: 40)
                }
                .navigationBarBackButtonHidden(true)
                .padding(10)
                .frame(maxWidth: .infinity)
                .frame(height: 120, alignment: .center)
                .background(Color("Blue1"))
                .clipShape (
                    bordesRedondo(
                        radio: 30,
                        esquina: [.bottomLeft, .bottomRight])
                )
                //MARK: Carta con información:
                VStack(spacing: 20) {
                    ZStack(alignment: .leading) {
                        VStack(spacing: 12) {
                            if cargando {
                                LottieView(name: "cargando", loopMode: .loop)
                                    .frame(height: 500)
                            } else if let errorMsg = errorMsg {
                                Text(errorMsg)
                                    .foregroundColor(.red)
                            } else if datos.isEmpty {
                                Text("No hay información para esta solicitud.")
                                    .foregroundColor(.gray)
                            } else {
                                ScrollView {
                                    VStack(spacing: 12) {
                                        ForEach(datos) { item in
                                            Text("\(item.prodescripcion)")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(Color("Blue1"))
                                                let detalle = detalleAdicional(item)
                                            if !detalle.isEmpty {
                                                Text(detalle)
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(Color("Red1"))
                                            }
                                            //MARK: Detalles generales
                                            VStack(alignment: .leading, spacing: 6) {
                                                let feccad = item.fechacad.date.formatearFecha()
                                                Text("Solicitud")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                    .padding(.bottom, -6)
                                                Text(verbatim: "\(solicitudID)")
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("WhiteBG"))
                                                Text("Datos Actuales/Solicitados")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(otrosCampos(item))
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .padding(10)
                                                HStack {
                                                    Text("Fecha de\ncaducidad")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                    Spacer()
                                                        .frame(width: 50)
                                                    Text("Solicitante")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                }
                                                .frame(width: 300, height: 50)
                                                .background(Color("Blue1"))
                                                .padding(.top, -6)
                                                HStack(spacing: 0) {
                                                    Text(feccad)
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.black)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .background(Color("WhiteBG"))
                                                    Text("\(item.solicitante)")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.black)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .background(Color("WhiteBG"))
                                                }
                                                .frame(width: 300, height: 50)
                                                .padding(.top, -5)
                                            }
                                            .padding(16)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                                            //MARK: Detalles solicitud
                                            VStack(alignment: .leading, spacing: 6) {
                                                let fecsol = "\(item.fechasol.date.formatearFechaHora())"
                                                let sla = "[\(item.sla) horas] \(item.fechasla.date.formatearFechaHora())"
                                                let motivo = "\(item.motivo) - \(item.motivodesc)"
                                                Text("Detalles de la solicitud")
                                                    .bold()
                                                    .font(.system(size: 16))
                                                    .frame(maxWidth: .infinity, alignment: .center)
                                                Text("Nivel: ").bold() + Text("\(item.nivel)")
                                                Text("Autoriza: ").bold() + Text("\(item.autoriza)")
                                                Text("Fecha de la solicitud: ").bold() + Text(fecsol)
                                                Text("SLA: ").bold() + Text(sla)
                                                Text("Motivo: ").bold() + Text(motivo)
                                                Text("Detalle del motivo: ").bold() + Text("\(item.motivodetalle)")
                                            }
                                            .padding(.top, 10)
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                //MARK: Botones
                                HStack(spacing: 20) {
                                    ForEach(datos) { item in
                                        Button {
                                            if let url = item.urlAutorizar {
                                                print("URL FINAL:", url.absoluteString)
                                            }
                                            prepararConfirmacion(url: item.urlAutorizar, accion: "Autorizar")
                                        } label: {
                                            boton(texto: "Autorizar", color: Color("Green1"))
                                        }
                                        Button {
                                            if let url = item.urlRechazar {
                                                print("URL FINAL:", url.absoluteString)
                                            }
                                            prepararConfirmacion(url: item.urlRechazar, accion: "Rechazar")
                                        } label: {
                                            boton(texto: "Rechazar", color: Color("Red1"))
                                        }
                                    }
                                }
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                if cargando {
                                    LoaderProcesoView()
                                        .ignoresSafeArea()
                                        .transition(.opacity)
                                        .zIndex(999)
                                }
                            }
                        }
                        .alert("Confirmación", isPresented: $confirmarAccion) {
                                    Button("Aceptar", role: .destructive) {
                                        if let url = urlSeleccionada {
                                            ejecutar(url: url)
                                        }
                                    }
                                    Button("Cancelar", role: .cancel) {
                                    }
                                } message: {
                                    Text("¿Deseas \(accionTexto) la solicitud?")
                                }
                                // Resultado
                                .alert("Resultado", isPresented: $mostrarAlerta) {
                                    Button("Aceptar", role: .cancel) {}
                                } message: {
                                    Text(mensajeAlerta)
                                }
                    }
                    .padding(.top, 10)
                }
                .padding()
                .frame(width: 380, height: 700, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 6)
                    .offset(y: 90)
            }
            .onAppear {
                cargar()
            }
        }
    }
    private func cargar() {
        cargando = true
        errorMsg = nil
        ClienteAPI.obtenerReingreso(solicitud: solicitudID) { result in
            cargando = false
            switch result {
            case .success(let arr):
                self.datos = arr.data
            case .failure(let error):
                self.errorMsg = "Error: \(error.localizedDescription)"
            }
        }
    }
    //MARK: Ejecución de enlaces de autorización
    private func boton(texto: String, color: Color) -> some View {
        Text(texto)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .frame(width: 130, height: 45)
            .background(color)
            .cornerRadius(25)
    }
    private func prepararConfirmacion(url: URL?, accion: String) {
        guard let url = url else { return }
        urlSeleccionada = url
        accionTexto = accion
        confirmarAccion = true
    }
    enum Accion {
        case autorizar
        case rechazar
    }
    private func ejecutar(url: URL){
        DispatchQueue.main.async {
            cargando = true
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                    cargando = false
            }
            if let error = error {
                DispatchQueue.main.async {
                    mensajeAlerta = "Error: \(error.localizedDescription)"
                    mostrarAlerta = true
                    return
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        mensajeAlerta = "Proceso aplicado correctamente"
                    } else {
                        mensajeAlerta = "Error del servidor: (\(httpResponse.statusCode)"
                    }
                    mostrarAlerta = true
                }
            }
        }.resume()
    }
    func detalleAdicional(_ item: Reingresos) -> String {
        if (item.temp == 1) {
            "Recontratación a puesto temporal"
        } else {
            "Recontratación"
        }
    }
    //MARK: Otros campos
    func otrosCampos(_ item: Reingresos) -> String {
        //Detalles en otros campos
        let salto = "\n\n"
        let fechabaja = item.fechabaja.date.formatearFecha()
        var otroscampos = "Colaborador: \(item.persid) - \(item.nom)" + salto
        otroscampos += "Fecha de baja: [\(fechabaja)]" + salto
        if item.pueact != item.puesol {
            let fechare = item.fechare.date.formatearFecha()
            otroscampos += "Fecha de reingreso solicitado  [\(fechare)]" + salto
            let areaact = "\(item.areaact) - \(item.areadescact)"
            let areasol = "\(item.areasol) - \(item.areadescsol)"
            otroscampos += "Área actual [\(areaact)] a integrarse: [\(areasol)]" + salto
            let pueact = "\(item.pueact) - \(item.puedescact)"
            let puesol = "\(item.puesol) - \(item.puedescsol)"
            otroscampos += "Puesto actual [\(pueact)] a integrarse: [\(puesol)]" + salto
            let catact = "\(item.catact) - \(item.catdescact)"
            let catsol = "\(item.catsol) - \(item.catdescsol)"
            otroscampos += "Categoría del puesto actual [\(catact)] a integrarse: [\(catsol)]" + salto
        } else {
            let fechare = item.fechare.date.formatearFecha()
            otroscampos += "Fecha de reingreso solicitado  [\(fechare)]" + salto
            let areaact = "\(item.areaact) - \(item.areadescact)"
            let areasol = "\(item.areasol) - \(item.areadescsol)"
            otroscampos += "Área actual [\(areaact)] Solicitado [\(areasol)]" + salto
            let pueact = "\(item.pueact) - \(item.puedescact)"
            let puesol = "\(item.puesol) - \(item.puedescsol)"
            otroscampos += "Puesto actual [\(pueact)] Solicitado [\(puesol)]" + salto
            let catact = "\(item.catact) - \(item.catdescact)"
            let catsol = "\(item.catsol) - \(item.catdescsol)"
            otroscampos += "Categoría del puesto actual [\(catact)] Solicitado [\(catsol)]" + salto
        }
        if item.temp == 1 {
            let fechatempini = item.fechatempini?.date.formatearFecha() ?? ""
            let fechatempfin = item.fechatempfin?.date.formatearFecha() ?? ""
            otroscampos += "Puesto temporal desde: \(fechatempini) Hasta: \(fechatempfin)" + salto
        } else {
            otroscampos += "Puesto Temporal: N/A" + salto
        }
        return otroscampos
    }
}
struct filaTablaReingreso: View {
    let titulo: String
    let valor: String
    var clave: Bool = false
    var claveColor: Color = Color("Green1")
    var claveAncho: Bool = false
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(titulo)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color("Blue1"))
                .frame(width: 150, alignment: .leading)
            if clave {
                if claveAncho {
                    Text(valor)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 10)
                        .background(claveColor)
                        .cornerRadius(10)
                } else {
                    Text(valor)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(claveColor)
                        .cornerRadius(10)
                }
            } else {
                Text(valor)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical, 6)
    }
}
