//
//  GeocercaView.swift
//  TestWF
//
//  Created by TI on 04/02/26.
//

import SwiftUI
import Foundation

struct GeocercaView: View {
    @Environment(\.dismiss) private var dismiss
    let solicitudID: Int
    @State private var cargando = true
    @State private var errorMsg: String? = nil
    @State private var datos: [Geocerca] = []
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
                                                let cliente = "\(item.cliente) - \(item.nom_cliente)"
                                                let contrato = "\(item.contrato) - \(item.nom_contrato)"
                                                let fecpago = item.ultpagofecha.date.formatearFecha()
                                                let feccad = item.fechacad.date.formatearFecha()
                                                let geoact = """
                                                Latitud actual: \(item.latact)
                                                Longitud actual: \(item.lonact)
                                                Radio actual: \(item.radact)
                                                """
                                                let geosol = """
                                                Latitud actual: \(item.latsol)
                                                Longitud actual: \(item.lonsol)
                                                Radio actual: \(item.radsol)
                                                """
                                                let geopermact = if (item.singeodefact == 1) {"SI"} else {"NO"}
                                                let geopermsol = if (item.singeodefsol == 1) {"SI"} else {"NO"}
                                                let singeoperm = """
                                                Actual: \(geopermact)
                                                Solicitado: \(geopermsol)
                                                """
                                                let geotempact = if (item.singeotempact == 1) {"SI"} else {"NO"}
                                                let geotempsol = if (item.singeotempsol == 1) {"SI"} else {"NO"}
                                                let singeotemp = """
                                                Actual: \(geotempact)
                                                Solicitado: \(geotempsol)
                                                """
                                                let fechadesde = item.singeotempdesde.date.formatearFechaHora()
                                                let fechahasta = item.singeotemphasta.date.formatearFechaHora()
                                                let rango = """
                                                Desde: \(fechadesde)
                                                Hasta: \(fechahasta)
                                                """
                                                let bloqueo = if (item.geobloq == 1) {"SI"} else {"NO"}
                                                Text("Solicitud")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(verbatim: "\(solicitudID)")
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .padding(.leading, 125)
                                                Text("Cliente")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(cliente)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .frame(width: 300, alignment: .center)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(4)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                Text("Contrato")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text("\(contrato)")
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 20)
                                                    Text("Geocerca actual")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 40)
                                                    Text("Geocerca solicitada")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .padding()
                                                }
                                                .frame(width: 300, height: 30)
                                                .background(Color("Blue1"))
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 10)
                                                    Text(geoact)
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 30)
                                                    Text(geosol)
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 10)
                                                }
                                                .frame(width: 300, height: 20)
                                                HStack {
                                                    Text("Sin geocerca permanente")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                    Spacer()
                                                        .frame(width: 30)
                                                    Text("Sin geocerca temporal")
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
                                                    Text(singeoperm)
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 20)
                                                    Text(singeotemp)
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
                                                Text("Rango de fechas")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(rango)
                                                .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.white)
                                                    .background(Color("Green"))
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                Text("Bloquear con geocerca")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(bloqueo)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 20)
                                                    Text("Saldo")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 40)
                                                    Text("Saldo vencido")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .padding()
                                                }
                                                .frame(width: 300, height: 30)
                                                .background(Color("Blue1"))
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 10)
                                                    Text("$\(item.saldo)")
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 30)
                                                    Text("$\(item.saldovencido)")
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                        .padding()
                                                    Spacer()
                                                        .frame(width: 10)
                                                }
                                                .frame(width: 300, height: 20)
                                                Text("Último pago")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text("Abonó: $\(item.ultpago) el \(fecpago)")
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
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
                                                /*filaTablaGeo(titulo: "Solicitud", valor: "\(solicitudID)")
                                                filaTablaGeo(titulo: "Cliente", valor: cliente)
                                                filaTablaGeo(titulo: "Contrato", valor: contrato)
                                                Divider()
                                                filaTablaGeo(titulo: "Geocerca actual", valor: geoact)
                                                filaTablaGeo(titulo: "Geocerca solicitado", valor: geosol)
                                                Divider()
                                                filaTablaGeo(titulo: "Sin geocerca permanente", valor: singeoperm)
                                                filaTablaGeo(titulo: "Sin geocerca temporal", valor: singeotemp, clave: true)
                                                Divider()
                                                filaTablaGeo(titulo: "Rango fechas", valor: rango, clave: true)
                                                filaTablaGeo(titulo: "Datos extra solicitados", valor: bloqueo)
                                                Divider()
                                                filaTablaGeo(titulo: "Saldo", valor: "$\(item.saldo)")
                                                filaTablaGeo(titulo: "Saldo vencido", valor: "$\(item.saldovencido)")
                                                filaTablaGeo(titulo: "Último pago", valor: "Abonó: $\(item.ultpago) el \(fecpago)")
                                                Divider()
                                                filaTablaGeo(titulo: "Fecha caducidad", valor: feccad)
                                                filaTablaGeo(titulo: "Solicitante", valor: "\(item.solicitante)")*/
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
                                                let cuenta = "\(item.cuenta) - \(item.nom_cuenta ?? "")"
                                                let motivo = "\(item.motivo) - \(item.motivodesc)"
                                                let compromiso = "\(item.comp) - \(item.compdesc)"
                                                let fechacomp = "\(item.compfecha.date.formatearFecha())"
                                                Text("Detalles de la solicitud")
                                                    .bold()
                                                    .font(.system(size: 16))
                                                    .frame(maxWidth: .infinity, alignment: .center)
                                                Text("Nivel: ").bold() + Text("\(item.nivel)")
                                                Text("Autoriza: ").bold() + Text("\(item.autoriza)")
                                                Text("Fecha de la solicitud: ").bold() + Text(fecsol)
                                                Text("SLA: ").bold() + Text(sla)
                                                Text("Días de crédito: ").bold() + Text("\(item.diascredito)")
                                                Text("Límite de crédito: ").bold() + Text("$\(item.limcredito)")
                                                Text("Días vencidos: ").bold() + Text("\(item.diasven)")
                                                Text("Cuenta contable: ").bold() + Text(cuenta)
                                                Text("Motivo: ").bold() + Text(motivo)
                                                Text("Detalle del motivo: ").bold() + Text("\(item.motivodetalle)")
                                                Text("Compromiso: ").bold() + Text(compromiso)
                                                Text("Detalle del compromiso: ").bold() + Text("\(item.compdetalle)")
                                                Text("Fecha del compromiso: ").bold() + Text(fechacomp)
                                                Text("Kilos del compromiso: ").bold() + Text("\(item.monto)")
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
        ClienteAPI.obtenerGeocerca(solicitud: solicitudID) { result in
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
struct filaTablaGeo: View {
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
