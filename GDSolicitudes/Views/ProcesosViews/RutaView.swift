//
//  RutaView.swift
//  TestWF
//
//  Created by TI on 04/02/26.
//

import SwiftUI
import Foundation

struct RutaView: View {
    @Environment(\.dismiss) private var dismiss
    let solicitudID: Int
    @State private var cargando = true
    @State private var errorMsg: String? = nil
    @State private var datos: [Rutas] = []
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
                .frame(width: .infinity, height: 120, alignment: .center)
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
                                            //MARK: Detalles generales
                                            VStack(alignment: .leading, spacing: 6) {
                                                let almacen = "\(item.almacen) - \(item.nom_almacen)"
                                                let vehiculo = "\(item.vehiculo) - \(item.numeco)"
                                                let fecha = item.fecha.date.formatearFecha()
                                                let chofer = "\(item.chofer) - \(item.chofernombre)"
                                                let feccad = item.fechacad.date.formatearFecha()
                                                Text("Solicitud")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(verbatim: "\(solicitudID)")
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                Text("Alamcén")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(almacen)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .frame(width: 300, alignment: .center)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(4)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                Text("RutaID")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text("\(item.ruta)")
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                HStack {
                                                    Text("Vehículo")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                    Spacer()
                                                        .frame(width: 30)
                                                    Text("Fecha")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                }
                                                .frame(width: 300, height: 50)
                                                .background(Color("Blue1"))
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 10)
                                                    Text(vehiculo)
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 20)
                                                    Text(fecha)
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 10)
                                                }
                                                .frame(width: 300, height: 30)
                                                .background(Color("Green"))
                                                .padding(.bottom, -7)
                                                .padding(.top, -6)
                                                Text("Chofer")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(chofer)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                HStack {
                                                    Text("Tipo de ruta")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                    Spacer()
                                                        .frame(width: 50)
                                                    Text("Estatus")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                }
                                                .frame(width: 300, height: 50)
                                                .background(Color("Blue1"))
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 30)
                                                    Text("\(item.tiporuta)")
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                    Spacer()
                                                        .frame(width: 20)
                                                    Text("\(item.estatus)")
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                        .truncationMode(.tail)
                                                        .padding()
                                                        .fixedSize(horizontal: false, vertical: true)
                                                }
                                                .frame(width: 300, height: 40)
                                                .padding(.top, -3)
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
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 30)
                                                    Text(feccad)
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                    Spacer()
                                                        .frame(width: 20)
                                                    Text("\(item.solicitante)")
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                        .truncationMode(.tail)
                                                        .padding()
                                                        .fixedSize(horizontal: false, vertical: true)
                                                }
                                                .frame(width: 300, height: 40)
                                                .padding(.top, -3)
                                                /*filaTablaRuta(titulo: "Solicitud", valor: "\(solicitudID)")
                                                filaTablaRuta(titulo: "Almacen", valor: almacen)
                                                filaTablaRuta(titulo: "RutaID", valor: "\(item.ruta)")
                                                Divider()
                                                filaTablaRuta(titulo: "Vehículo", valor: vehiculo, clave: true)
                                                filaTablaRuta(titulo: "Fecha", valor: fecha, clave: true)
                                                Divider()
                                                filaTablaRuta(titulo: "Chofer", valor: chofer)
                                                filaTablaRuta(titulo: "Tipo ruta", valor: "\(item.tiporuta)")
                                                filaTablaRuta(titulo: "Estatus", valor: "\(item.estatus)")
                                                Divider()
                                                filaTablaRuta(titulo: "Fecha caducidad", valor: feccad)
                                                filaTablaRuta(titulo: "Solicitante", valor: "\(item.solicitante)")*/
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
                                    Button(action: {
                                        print("Autorizar")
                                    }) {
                                        Text("Autorizar")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 45)
                                            .background(Color("Green"))
                                            .cornerRadius(25)
                                    }
                                    Button(action: {
                                        print("Rechazar")
                                    }) {
                                        Text("Rechazar")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                            .frame(width: 130, height: 45)
                                            .background(Color("Red"))
                                            .cornerRadius(25)
                                    }
                                }
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            }
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
        ClienteAPI.obtenerRuta(solicitud: solicitudID) { result in
            cargando = false
            switch result {
            case .success(let arr):
                self.datos = arr.data
            case .failure(let error):
                self.errorMsg = "Error: \(error.localizedDescription)"
            }
        }
    }
}
struct filaTablaRuta: View {
    let titulo: String
    let valor: String
    var clave: Bool = false
    var claveColor: Color = Color("Green")
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
