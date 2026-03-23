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
    //Archivos
    @State private var archivos: [Archivo] = []
    @State private var tieneArchivos = false
    @State private var cargandoArchivos = false
    @State private var mostrarArchivos = false
    @State private var mostrandoLoader = false
    @State private var mostrarAlerta = false
    @State private var mensajeAlerta = ""
    @State private var confirmarAccion = false
    @State private var urlSeleccionada: URL?
    @State private var accionTexto = ""
    @State private var procesando = false
    @State private var accionPendiente: Accion? = nil
    @State private var urlPendiente: URL? = nil
    //Detalles adicionales
    @State private var facturasVencidas: [Facturas] = []
    @State private var solicitudesAutorizadas: [SolicitudesAutorizadas] = []
    @State private var contratosCliente: [Contratos] = []
    @State private var descuentosCliente: [Descuentos] = []
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
                    Group {
                        // Si está cargando, mostramos la animación de carga sin importar 'tieneArchivos'
                        if cargandoArchivos {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(width: 30, height: 30)
                                .padding(.leading, 30)
                        }
                        // Si NO está cargando, pero sabemos que SÍ hay archivos, mostramos el clip
                        else if tieneArchivos {
                            Button(action: {
                                mostrarArchivos = true
                            }) {
                                Image(systemName: "paperclip")
                                    .foregroundColor(.white)
                                    .padding(.leading, 30)
                                    .font(.system(size: 20, weight: .bold))
                            }
                        }
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
                                                Latitud solicitado: \(item.latsol)
                                                Longitud solicitado: \(item.lonsol)
                                                Radio solicitado: \(item.radsol)
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
                                                Text("Cliente")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                    .padding(.top, -6)
                                                    .padding(.bottom, -6)
                                                Text(cliente)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .frame(width: 300, alignment: .center)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(4)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .background(Color("WhiteBG"))
                                                Text("Contrato")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                    .padding(.top, -6)
                                                    .padding(.bottom, -6)
                                                Text(contrato)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .frame(width: 300, alignment: .center)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(4)
                                                    .truncationMode(.tail)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .background(Color("WhiteBG"))
                                                HStack {
                                                    Text("Geocerca\nactual")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                    Spacer()
                                                        .frame(width: 80)
                                                    Text("Geocerca\nsolicitada")
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
                                                    Text(geoact)
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                    Spacer()
                                                        .frame(width: 30)
                                                    Text(geosol)
                                                        .font(.system(size: 15, weight: .regular))
                                                        .foregroundColor(.black)
                                                    Spacer()
                                                        .frame(width: 10)
                                                }
                                                .frame(width: 300, height: 140)
                                                .multilineTextAlignment(.center)
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
                                                HStack(spacing: 0) {
                                                    if item.singeodefsol == 1 {
                                                        Text(singeoperm)
                                                            .font(.system(size: 15, weight: .bold))
                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                            .foregroundColor(.white)
                                                            .background(Color("Green1"))
                                                            .multilineTextAlignment(.center)
                                                    } else {
                                                        Text(singeoperm)
                                                            .font(.system(size: 15, weight: .bold))
                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                            .foregroundColor(.white)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    if item.singeotempsol == 1 {
                                                        Text(singeotemp)
                                                            .font(.system(size: 15, weight: .bold))
                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                            .foregroundColor(.white)
                                                            .background(Color("Green1"))
                                                            .multilineTextAlignment(.center)
                                                    } else {
                                                        Text(singeotemp)
                                                            .font(.system(size: 15, weight: .bold))
                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                            .foregroundColor(.white)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                }
                                                .frame(width: 300, height: 50)
                                                Text("Rango de fechas")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(rango)
                                                    .font(.system(size: 15, weight: .bold))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.white)
                                                    .frame(width: 300, height: 50)
                                                    .background(Color("Green1"))
                                                    .padding(.bottom, -7)
                                                    .padding(.top, -6)
                                                Text("Bloquear con geocerca")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                Text(bloqueo)
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .padding(.leading, 140)
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
                                                HStack(spacing: 0) {
                                                    Text("$\(item.saldo)")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.black)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .background(Color("WhiteBG"))
                                                    Text("$\(item.saldovencido)")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.black)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .background(Color("WhiteBG"))
                                                }
                                                .frame(width: 300, height: 30)
                                                .padding(.bottom, -6)
                                                .padding(.top, -6)
                                                Text("Último pago")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("Blue1"))
                                                    .padding(.bottom, -6)
                                                Text("Abonó: $\(item.ultpago) el \(fecpago)")
                                                    .font(.system(size: 15, weight: .regular))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 300, height: 30)
                                                    .background(Color("WhiteBG"))
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
                                            if !facturasVencidas.isEmpty {
                                                VStack(alignment: .leading, spacing: 0) {
                                                    Text("Facturas con saldo vencido")
                                                        .bold()
                                                        .font(.system(size: 16))
                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                        .padding(.bottom, 10)
                                                    ScrollView(.horizontal) {
                                                        VStack (spacing: 0) {
                                                            HStack(spacing: 0){
                                                                Text("Factura")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 100, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Fecha")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 100, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Fecha vencimiento")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Cargo")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Abono")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Saldo")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Saldo vencido")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 120, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("s7D")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("s15D")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("s30D")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("s60D")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("s1AÑO")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("sM1AÑO")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                            }
                                                            ForEach(facturasVencidas) { factura in
                                                                let fact = "\(factura.concepto)\(factura.folio)"
                                                                let fecha = "\(factura.fecha.date.formatearFecha())"
                                                                let fechaven = "\(factura.fechaven.date.formatearFechaHora())"
                                                                HStack(spacing: 0){
                                                                    Text(verbatim: fact)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 100, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(fecha)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 100, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(fechaven)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.cargo)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.abono)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.saldo)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.vencido)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 120, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.s7d)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.s15d)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.s30d)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.s60d)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.sano)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(factura.smano)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                .padding(.top, 5)
                                                .font(.system(size: 15))
                                                .foregroundColor(.black)
                                                .frame(maxWidth: 300, maxHeight: .infinity, alignment: .leading)
                                            }
                                            if !solicitudesAutorizadas.isEmpty {
                                                VStack(alignment: .leading, spacing: 6) {
                                                    Text("Solicitudes autorizadas")
                                                        .bold()
                                                        .font(.system(size: 16))
                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                        .padding(.bottom, 10)
                                                    ScrollView(.horizontal) {
                                                        VStack (spacing: 0) {
                                                            HStack(spacing: 0){
                                                                Text("Solicitud")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 220, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Cliente")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 220, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Contrato")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 220, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Geocerca actual")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Geocerca solicitada")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Sin geocerca permanente")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Sin geocerca temporal")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Rango de fechas")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Bloquear con geocerca")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Saldo")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Saldo vencido")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 120, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Último pago")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                                Text("Solicitante")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 200, height: 60)
                                                                    .background(Color("Blue1"))
                                                            }
                                                            ForEach(solicitudesAutorizadas) { solaut in
                                                                let fecha = "\(solaut.fechaaut.date.formatearFecha())"
                                                                let solicitud = "\(solaut.solicitud) del \(fecha)"
                                                                let cliente = "\(solaut.cliente) - \(solaut.nomcliente)"
                                                                let contrato = "\(solaut.contrato) - \(solaut.nomcontrato)"
                                                                let geoact = """
                                                                Latitud actual: \(solaut.latact)
                                                                Longitud actual: \(solaut.lonact)
                                                                Radio actual: \(solaut.radact)
                                                                """
                                                                let geosol = """
                                                                Latitud solicitado: \(solaut.latsol)
                                                                Longitud solicitado: \(solaut.lonsol)
                                                                Radio solicitado: \(solaut.radsol)
                                                                """
                                                                let geopermact = if (solaut.geopermact == 1) {"SI"} else {"NO"}
                                                                let geopermsol = if (solaut.geopermsol == 1) {"SI"} else {"NO"}
                                                                let singeoperm = """
                                                                Actual: \(geopermact)
                                                                Solicitado: \(geopermsol)
                                                                """
                                                                let geotempact = if (solaut.geotempact == 1) {"SI"} else {"NO"}
                                                                let geotempsol = if (solaut.geotempsol == 1) {"SI"} else {"NO"}
                                                                let singeotemp = """
                                                                Actual: \(geotempact)
                                                                Solicitado: \(geotempsol)
                                                                """
                                                                let fechadesde = solaut.geotempfecdesde.date.formatearFechaHora()
                                                                let fechahasta = solaut.geotempfechasta.date.formatearFechaHora()
                                                                let rango = """
                                                                Desde: \(fechadesde)
                                                                Hasta: \(fechahasta)
                                                                """
                                                                let bloqueo = if (item.geobloq == 1) {"SI"} else {"NO"}
                                                                let fecpago = "\(solaut.ultpagofecha.date.formatearFecha())"
                                                                let ultpago = "Abonó $\(solaut.ultpago) el \(fecpago)"
                                                                HStack(spacing: 0){
                                                                    Text(solicitud)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 220, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(cliente)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 220, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(contrato)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(geoact)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(geosol)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(singeoperm)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(singeotemp)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(rango)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(bloqueo)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(solaut.saldo)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(solaut.saldoven)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 120, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(ultpago)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("\(solaut.solicitante)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 200, height: 60)
                                                                        .background(Color("WhiteBG"))
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                .padding(.top, 5)
                                                .font(.system(size: 15))
                                                .foregroundColor(.black)
                                                .frame(maxWidth: 300, maxHeight: .infinity, alignment: .leading)
                                            }
                                            if !contratosCliente.isEmpty {
                                                VStack(alignment: .leading, spacing: 6) {
                                                    Text("Contratos del cliente")
                                                        .bold()
                                                        .font(.system(size: 16))
                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                        .padding(.bottom, 10)
                                                    ScrollView(.horizontal) {
                                                        VStack (spacing: 0) {
                                                            HStack(spacing: 0){
                                                                Text("Contrato")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 220, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Tipo venta")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Tipo contrato")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 120, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Tipo precio")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 120, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Precio")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                            }
                                                            ForEach(contratosCliente) { con in
                                                                let contrato = "\(con.contrato) - \(con.nombre)"
                                                                let tipo = "\(con.tipo) - \(con.tipodesc)"
                                                                let tipopre = "\(con.tipopre) - \(con.tipopredesc)"
                                                                HStack(spacing: 0){
                                                                    Text(contrato)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 220, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("\(con.venta)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(tipo)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 120, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(tipopre)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 120, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(con.precio)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                .padding(.top, 5)
                                                .font(.system(size: 15))
                                                .foregroundColor(.black)
                                                .frame(maxWidth: 300, maxHeight: .infinity, alignment: .leading)
                                            }
                                            if !descuentosCliente.isEmpty {
                                                VStack(alignment: .leading, spacing: 6) {
                                                    Text("Descuentos del cliente")
                                                        .bold()
                                                        .font(.system(size: 16))
                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                        .padding(.bottom, 10)
                                                    ScrollView(.horizontal) {
                                                        VStack (spacing: 0) {
                                                            HStack(spacing: 0){
                                                                Text("Artículo")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 120, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Descuento")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Tipo")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 80, height: 30)
                                                                    .background(Color("Blue1"))
                                                                Text("Autómatico")
                                                                    .foregroundColor(.white)
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .frame(width: 100, height: 30)
                                                                    .background(Color("Blue1"))
                                                            }
                                                            ForEach(descuentosCliente) { desc in
                                                                let articulo = "\(desc.articulo) - \(desc.desc)"
                                                                let automatico = if desc.auto == 1 { "True" } else { "False" }
                                                                HStack(spacing: 0){
                                                                    Text(articulo)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 120, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("$\(desc.desc)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text("\(desc.tipo)")
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 80, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                    Text(automatico)
                                                                        .foregroundColor(.black)
                                                                        .frame(width: 100, height: 30)
                                                                        .background(Color("WhiteBG"))
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                .padding(.top, 5)
                                                .font(.system(size: 15))
                                                .foregroundColor(.black)
                                                .frame(maxWidth: 300, maxHeight: .infinity, alignment: .leading)
                                            }
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
            .sheet(isPresented: $mostrarArchivos) {
                ArchivosView(archivos: archivos)
                    .presentationDetents([.medium, .large])
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
                cargarArchivos()
                if let item = arr.data.first {
                    let empresa = item.emp
                    let cliente = item.cliente
                    let proceso = item.procesoid
                    let solicitud = item.solicitud
                    cargarFacturasVencidas(empresa: empresa, solicitud: solicitud, cliente: cliente)
                    cargarSolicitudesAutorizadas(empresa: empresa, proceso: proceso, cliente: cliente)
                    cargarContratosCliente(empresa: empresa, cliente: cliente)
                    cargarDescuentosCliente(empresa: empresa, cliente: cliente)
                }
            case .failure(let error):
                self.errorMsg = "Error: \(error.localizedDescription)"
            }
        }
    }
    private func cargarArchivos() {
        cargandoArchivos = true
        ClienteAPI.obtenerArchivo(solicitud: solicitudID) { result in
            DispatchQueue.main.async {
                cargandoArchivos = false
                switch result {
                case .success(let response):
                    self.archivos = response.data
                    self.tieneArchivos = !response.data.isEmpty
                    print("Archivos encontrados:", response.data.count)
                case .failure(let error):
                    print("Error:",error.localizedDescription)
                    self.tieneArchivos = false
                }
            }
        }
    }
    //MARK: Carga de datos extra
    private func cargarFacturasVencidas(empresa: Int, solicitud: Int, cliente: Int) {
        ClienteAPI.obtenerFacturasVencidas(empresa: empresa, solicitud: solicitud, cliente: cliente) { result in
            switch result {
            case .success(let response):
                self.facturasVencidas = response.data
            case .failure(let error):
                print("Error facturas vencidas:", error)
            }
        }
    }
    private func cargarSolicitudesAutorizadas(empresa: Int, proceso: Int, cliente: Int) {
        ClienteAPI.obtenerSolicitudesAutorizadas(empresa: empresa, proceso: proceso, cliente: cliente) { result in 
            switch result {
            case .success(let response):
                self.solicitudesAutorizadas = response.data
            case .failure(let error):
                print("Error solicitudes autorizadas:", error)
            }
        }
    }
    private func cargarContratosCliente(empresa: Int, cliente: Int) {
        ClienteAPI.obtenerContratoCliente(empresa: empresa, cliente: cliente) { result in
            switch result {
            case .success(let response):
                self.contratosCliente = response.data
            case .failure(let error):
                print("Error contratos cliente:", error)
            }
        }
    }
    private func cargarDescuentosCliente(empresa: Int, cliente: Int) {
        ClienteAPI.obtenerDescuentoCliente(empresa: empresa, cliente: cliente) { result in 
            switch result {
            case .success(let response):
                self.descuentosCliente = response.data
            case .failure(let error):
                print("Error descuentos cliente:", error)
            }
        }
    }
    func detalleAdicional(_ item: Geocerca) -> String {
        let lonSol = Int(item.lonsol) ?? 0
        let latSol = Int(item.latsol) ?? 0
        if ((item.latact != item.latsol) || (item.lonact != item.lonsol) || (item.radact != item.radsol)) &&
           ((lonSol > 0) || (latSol > 0) || (item.radsol > 0)) {
            return "Cambio de geocerca"
        } else if item.singeodefsol == 1 {
            return "Quitar geocerca permanente"
        } else if item.singeotempsol == 1 {
            return "Quitar geocerca temporalmente"
        } else if item.geobloq == 1 {
            return "Bloquear con geocerca"
        } else {
            return ""
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
}
struct filaTablaGeo: View {
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
