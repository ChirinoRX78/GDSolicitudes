//
//  PersonalView.swift
//  TestWF
//
//  Created by TI on 04/02/26.
//

import SwiftUI
import Foundation

struct PersonalView: View {
    @Environment(\.dismiss) private var dismiss
    let solicitudID: Int
    @State private var cargando = true
    @State private var errorMsg: String? = nil
    @State private var datos: [Personal] = []
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
                        if tieneArchivos {
                            if cargandoArchivos {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 30, height: 30)
                            } else if tieneArchivos {
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
                    }
                    .frame(width: 40, height: 40)
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
            .sheet(isPresented: $mostrarArchivos) {
                ArchivosView(archivos: archivos)
                    .presentationDetents([.medium, .large])
            }
        }
    }
    private func cargar() {
        cargando = true
        errorMsg = nil
        ClienteAPI.obtenerPersonal(solicitud: solicitudID) { result in
            cargando = false
            switch result {
            case .success(let arr):
                self.datos = arr.data
                cargarArchivos()
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
//                    print("Nombre de archivo: ", response.data)
                case .failure(let error):
                    print("Error:",error.localizedDescription)
                    self.tieneArchivos = false
                }
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
    func detalleAdicional(_ item: Personal) -> String {
        if (item.nuevo == 1 && item.soltemp == 1) {
            "Alta de personal, con puesto temporal"
        } else if (item.nuevo == 1 && item.famempsol == 1) {
            "Alta de personal, con familiar en la empresa"
        } else if (item.nuevo == 1 && item.contcompsol == 1) {
            "Alta de personal, viene de competencia"
        } else if (item.nuevo == 1) {
            "Alta de personal"
        } else {
            "Edición de información"
        }
    }
    //MARK: Otros campos
    func otrosCampos(_ item: Personal) -> String {
        //Detalles en otros campos
        let salto = "\n\n"
        var otroscampos = "Categoría del puesto [\(item.catpers) - \(item.catpersdesc)]" + salto
        if item.contcompact != item.contcompsol {
            let contcompact = if(item.contcompact == 1) { "SI" } else {"NO"}
            let contcompsol = if(item.contcompsol == 1) { "SI" } else {"NO"}
            otroscampos += "Contratación competencia actual: [\(contcompact)] Solicitado: [\(contcompsol)]" + salto
        }
        let famact = if(item.contcompact == 1) { "SI" } else {"NO"}
        let famsol = if(item.contcompsol == 1) { "SI" } else {"NO"}
        otroscampos += "Familiares en la empresa actual: [\(famact)] Solicitado: [\(famsol)]" + salto
        if item.soltemp == 1 {
            let fechatempini = item.fechatempini?.date.formatearFecha()
            let fechatempfin = item.fechatempfin?.date.formatearFecha()
            otroscampos += "Puesto temporal desde: \(fechatempini ?? "") Hasta: \(fechatempfin ?? "")" + salto
        } else {
            otroscampos += "Puesto temporal: N/A" + salto
        }
        let nombreact = "\(item.nomact) \(item.apepatact) \(item.apematact)"
        let nombresol = "\(item.nomsol) \(item.apepatsol) \(item.apematsol)"
        otroscampos += "Nombre Actual: [\(nombreact)] Solicitado: [\(nombresol)]" + salto
        otroscampos += "Puesto Actual: [\(item.puestoact) - \(item.puestodescact)] Solicitado: [\(item.puestosol) - \(item.puestodescsol)]" + salto
        if item.famempact != item.famempsol {
            if item.nomfamact != item.nomfamsol {
                otroscampos += "Nombre del familiar actual: [\(item.nomfamact)] Solicitado: [\(item.nomfamsol)]" + salto
            }
            if item.areafamact != item.areafamsol {
                otroscampos += "Área del familiar actual: [\(item.areafamact) - \(item.areafamdescact)] Solicitado: [\(item.areafamsol) - \(item.areafamsol)]" + salto
            }
            if item.puestofamact != item.puestofamsol {
                otroscampos += "Puesto del familiar actual: [\(item.puestofamact) - \(item.puestofamdescact)] Solicitado: [\(item.puestofamsol) - \(item.puestofamdescsol)]" + salto
            }
            if item.parfamact != item.parfamsol {
                otroscampos += "Parentesco del familiar actual: [\(item.parfamact) - \(item.parfamdescact)] Solicitado: [\(item.parfamsol) - \(item.parfamdescsol)]" + salto
            }
            if item.fechainfamact != nil || item.fechainfamsol != nil {
                let fechaIngAct = item.fechainfamact?.date.formatearFecha() ?? ""
                let fechaIngSol = item.fechainfamsol?.date.formatearFecha() ?? ""
                otroscampos += "Fecha de ingreso del familiar actual: [\(fechaIngAct)] Solicitado: [\(fechaIngSol)]" + salto
            }
        }
        if item.areaact != item.areasol {
            otroscampos += "Área actual: [\(item.areaact) - \(item.areadescact)] Solicitado: [\(item.areasol) - \(item.areadescsol)]" + salto
        }
        if item.numempact != item.numempsol {
            otroscampos += "Número de empleado actual: [\(item.numempact)] Solicitado: [\(item.numempsol)]" + salto
        }
        if item.fechainact != nil || item.fechainsol != nil {
            let fechainAct = item.fechainact?.date.formatearFecha() ?? ""
            let fechainSol = item.fechainsol?.date.formatearFecha() ?? ""
            otroscampos += "Fecha de ingreso actual: [\(fechainAct)] Solicitado: [\(fechainSol)]" + salto
        }
        if item.fechabajaact != nil {
            let fechabajaAct = item.fechabajaact?.date.formatearFecha() ?? ""
            let fechabajaSol = item.fechabajasol?.date.formatearFecha() ?? ""
            otroscampos += "Fecha de baja actual: [\(fechabajaAct)] Solicitado: [\(fechabajaSol)]" + salto
        }
        if item.fechanacact != nil {
            let fechanacAct = item.fechanacact?.date.formatearFecha() ?? ""
            let fechanacSol = item.fechanacsol?.date.formatearFecha() ?? ""
            otroscampos += "Fecha de nacimiento actual: [\(fechanacAct)] Solicitado: [\(fechanacSol)]" + salto
        }
        if item.curpact != item.curpsol {
            otroscampos += "CURP actual: [\(item.curpact)] Solicitado: [\(item.curpsol)]" + salto
        }
        if item.tipocontact != item.tipocontsol {
            otroscampos += "Tipo de contrato actual: [\(item.tipocontact)] Solicitado: [\(item.tipocontsol)]" + salto
        }
        if item.sangrecact != item.sangrecsol {
            otroscampos += "Tipo de sangre actual: [\(item.sangrecact) - \(item.tiposangrecact)] Solicitado: [\(item.sangrecsol) - \(item.tiposangrecsol)]" + salto
        }
        if item.domact != item.domsol {
            otroscampos += "Domicilio actual: [\(item.domact)] Solicitado: [\(item.domsol)]" + salto
        }
        if item.numextact != item.numextsol {
            otroscampos += "No. exterior actual: [\(item.numextact)] Solicitado: [\(item.numextsol)]" + salto
        }
        if item.numintact != item.numintsol {
            otroscampos += "No. interior actual: [\(item.numintact)] Solicitado: [\(item.numintsol)]" + salto
        }
        if item.cpsatact != item.cpsatsol {
            otroscampos += "CP Actual: [\(item.cpsatact)] Solicitado: [\(item.cpsatsol)]" + salto
        }
        if item.paissatact != item.paissatsol {
            otroscampos += "País Actual: [\(item.paissatact)] Solicitado: [\(item.paissatsol)]" + salto
        }
        if item.edosatidact != item.edosatidsol {
            otroscampos += "Estado Actual: [\(item.edosatidact)] Solicitado: [\(item.edosatidsol)]" + salto
        }
        if item.munsatact != item.munsatsol {
            otroscampos += "Municipio Actual: [\(item.munsatact)] Solicitado: [\(item.munsatsol)]" + salto
        }
        if item.locsatact != item.locsatsol {
            otroscampos += "Localidad Actual: [\(item.locsatact)] Solicitado: [\(item.locsatsol)]" + salto
        }
        if item.colsatact != item.colsatsol {
            otroscampos += "Colonia Actual: [\(item.colsatact)] Solicitado: [\(item.colsatsol)]" + salto
        }
        if item.telact != item.telsol {
            otroscampos += "Teléfonos actual: [\(item.telact)] Solicitado: [\(item.telsol)]" + salto
        }
        if item.tel2act != item.tel2sol {
            otroscampos += "Teléfono 2 actual: [\(item.tel2act)] Solicitado: [\(item.tel2sol)]" + salto
        }
        if item.numssact != item.numsssol {
            otroscampos += "Número de Seguridad Social actual: [\(item.numssact)] Solicitado: [\(item.numsssol)]" + salto
        }
        if item.rfcact != item.rfcsol {
            otroscampos += "RFC actual: [\(item.rfcact)] Solicitado: [\(item.rfcsol)]" + salto
        }
        if item.catcomact != item.catcomsol {
            otroscampos += "Categoría de comisiones actual: [\(item.catcomact)] Solicitado: [\(item.catcomsol)]" + salto
        }
        if item.domemgact != item.domemgsol {
            otroscampos += "Domicilio de emergencia actual: [\(item.domemgact)] Solicitado: [\(item.domemgsol)]" + salto
        }
        if item.telemgact != item.telemgsol {
            otroscampos += "Teléfono de emergencia actual: [\(item.telemgact)] Solicitado: [\(item.telemgsol)]" + salto
        }
        if item.usuact != item.ususol {
            otroscampos += "Usuario actual: [\(item.usuact)] Solicitado: [\(item.ususol)]" + salto
        }
        if item.privhoraentact != item.privhoraentsol {
            otroscampos += "Privilegio hora entrada actual: [\(item.privhoraentact)] Solicitado: [\(item.privhoraentsol)]" + salto
        }
        if item.privhorasalact != item.privhorasalsol {
            otroscampos += "Privilegio hora salida actual: [\(item.privhorasalact)] Solicitado: [\(item.privhorasalsol)]" + salto
        }
        if item.privasisact != item.privasissol {
            otroscampos += "Privilegio asistencia actual: [\(item.privasisact)] Solicitado: [\(item.privasissol)]" + salto
        }
        if item.joract != item.jorsol {
            otroscampos += "Jornada actual: [\(item.joract)] Solicitado: [\(item.jorsol)]" + salto
        }
        if item.tipojoract != item.tipojorsol {
            otroscampos += "Tipo de jornada actual: [\(item.tipojoract)] Solicitado: [\(item.tipojorsol)]" + salto
        }
        if item.permhueact != item.permhuesol {
            otroscampos += "Permitir huella actual: [\(item.permhueact)] Solicitado: [\(item.permhuesol)]" + salto
        }
        if item.permhuenipact != item.permhuenipsol {
            otroscampos += "Permitir NIP + huella actual: [\(item.permhuenipact)] Solicitado: [\(item.permhuenipsol)]" + salto
        }
        if item.permtaract != item.permtarsol {
            otroscampos += "Permitir tarjeta actual: [\(item.permtaract)] Solicitado: [\(item.permtarsol)]" + salto
        }
        if item.permtarhueact != item.permtarhuesol {
            otroscampos += "Permitir tarjeta + huella actual: [\(item.permtarhueact)] Solicitado: [\(item.permtarhuesol)]" + salto
        }
        if item.horasextact != item.horasextsol {
            otroscampos += "Horas extra actual: [\(item.horasextact)] Solicitado: [\(item.horasextsol)]" + salto
        }
        if item.nivelsegact != item.nivelsegsol {
            otroscampos += "Nivel de seguridad actual: [\(item.nivelsegact)] Solicitado: [\(item.nivelsegsol)]" + salto
        }
        if item.nipact != item.nipsol {
            otroscampos += "NIP actual: [*****] Solicitado: [*****]" + salto
        }
        if item.ctadeudact != item.ctadeudsol {
            otroscampos += "Cuenta deudor actual: [\(item.ctadeudact) - \(item.ctadeuddescact)] Solicitado: [\(item.ctadeudsol) - \(item.ctadeuddescsol)]" + salto
        }
        if item.ctaacreact != item.ctaacresol {
            otroscampos += "Cuenta acreedor actual: [\(item.ctaacreact) - \(item.ctaacredescact)] Solicitado: [\(item.ctaacresol) - \(item.ctaacredescsol)]" + salto
        }
        if item.ctanomact != item.ctanomsol {
            otroscampos += "Cuenta nómina actual: [\(item.ctanomact) - \(item.ctanomdescact)] Solicitado: [\(item.ctanomsol) - \(item.ctanomdescsol)]" + salto
        }
        if item.tiponomact != item.tiponomsol {
            otroscampos += "Tipo nómina actual: [\(item.tiponomact) - \(item.tiponomdescact)] Solicitado: [\(item.tiponomsol) - \(item.tiponomdescsol)]" + salto
        }
        if item.aguiact != item.aguisol {
            otroscampos += "Días de aguinaldo actual: [\(item.aguiact)] Solicitado: [\(item.aguisol)]" + salto
        }
        if item.vacact != item.vacsol {
            otroscampos += "Días de vacaciones actual: [\(item.vacact)] Solicitado: [\(item.vacsol)]" + salto
        }
        if item.sueldoimssact != item.sueldoimsssol {
            otroscampos += "Sueldo diario IMSS actual: [$\(item.sueldoimssact)] Solicitado: [$\(item.sueldoimsssol)]" + salto
        }
        if item.tiposalact != item.tiposalsol {
            otroscampos += "Tipo salario actual: [\(item.tiposalact) - \(item.tiposaldescact)] Solicitado: [\(item.tiposalsol) - \(item.tiposaldescsol)]" + salto
        }
        if item.sucact != item.sucsol {
            otroscampos += "Sucursal actual: [\(item.sucact) - \(item.sucdescact)] Solicitado: [\(item.sucsol) - \(item.sucdescsol)]" + salto
        }
        if item.ctabcoact != item.ctabcosol {
            otroscampos += "Cuenta bancaria actual: [\(item.ctabcoact)] Solicitado: [\(item.ctabcosol)]" + salto
        }
        if item.numtaract != item.numtarsol {
            otroscampos += "Número de tarjeta actual: [\(item.numtaract)] Solicitado: [\(item.numtarsol)]" + salto
        }
        if item.salbiantact != item.salbiantsol {
            otroscampos += "Salario bimestral anterior actual: [$\(item.salbiantact)] Solicitado: [$\(item.salbiantsol)]" + salto
        }
        let tieneInfoAct = item.infoact == 1
        let tieneInfoSol = item.infosol == 1
        let procesaInfonavit = item.infoact != item.infosol || tieneInfoAct || tieneInfoSol
        if procesaInfonavit {
            otroscampos += "Tiene Infonavit actual: [\(tieneInfoAct ? "SI" : "NO")] Solicitado: [\(tieneInfoSol ? "SI" : "NO")]" + salto
            if item.amoract != item.amorsol {
                otroscampos += "Infonavit - Tipo amortización actual: [\(item.amoract)] Solicitado: [\(item.amorsol)]" + salto
            }
            if item.numcredact != item.numcredsol {
                otroscampos += "Infonavit - Número de crédito actual: [\(item.numcredact)] Solicitado: [\(item.numcredsol)]" + salto
            }
            if item.porcinfoact != item.porcinfosol {
                otroscampos += "Infonavit - % Infonavit actual: [\(item.porcinfoact)] Solicitado: [\(item.porcinfosol)]" + salto
            }
            if item.porcfijaact != item.porcfijasol {
                otroscampos += "Infonavit - % Cuota fija actual: [\(item.porcfijaact)] Solicitado: [\(item.porcfijasol)]" + salto
            }
            if item.amormenact != item.amormensol {
                otroscampos += "Infonavit - Amortización mensual actual: [\(item.amormenact)] Solicitado: [\(item.amormensol)]" + salto
            }
            let fechaIniAct = item.fechainidescinfoact?.date.formatearFecha() ?? ""
            let fechaIniSol = item.fechainidescinfosol?.date.formatearFecha() ?? ""
            if !fechaIniAct.isEmpty || !fechaIniSol.isEmpty {
                otroscampos += "Fecha inicio descuento Infonavit actual: [\(fechaIniAct)] Solicitado: [\(fechaIniSol)]" + salto
            }
        }
        if item.turnoact != item.turnosol {
            otroscampos += "Turno actual: [\(item.turnoact) - \(item.turnodescact)] Solicitado: [\(item.turnosol) - \(item.turnodescsol)]" + salto
        }
        if item.cedact != item.cedsol {
            otroscampos += "Cédula actual: [\(item.cedact)] Solicitado: [\(item.cedsol)]" + salto
        }
        if item.recontact != item.recontsol {
            otroscampos += "Permitir recontratar actual: [\(item.recontact)] Solicitado: [\(item.recontsol)]" + salto
        }
        if item.suaact != item.suasol {
            otroscampos += "Alta SUA actual: [\(item.suaact)] Solicitado: [\(item.suasol)]" + salto
        }
        if item.modopagoact != item.modopagosol {
            otroscampos += "Modo de pago actual: [\(item.modopagoact) - \(item.modopagodescact)] Solicitado: [\(item.modopagosol) - \(item.modopagodescsol)]" + salto
        }
        if item.estcredact != item.estcredsol {
            otroscampos += "Estatus credencial actual: [\(item.estcredact) - \(item.estcreddescact)] Solicitado: [\(item.estcredsol) - \(item.estcreddescsol)]" + salto
        }
        if item.grupoact != item.gruposol {
            otroscampos += "Grupo actual: [\(item.grupoact) - \(item.grupodescact)] Solicitado: [\(item.gruposol) - \(item.grupodescsol)]" + salto
        }
        if item.nacact != item.nacsol {
            otroscampos += "Lugar de nacimiento actual: [\(item.nacact)] Solicitado: [\(item.nacsol)]" + salto
        }
        if item.sexoact != item.sexosol {
            otroscampos += "Sexo actual: [\(item.sexoact) - \(item.sexodescact)] Solicitado: [\(item.sexosol) - \(item.sexodescsol)]" + salto
        }
        if item.civact != item.civsol {
            otroscampos += "Estado civil actual: [\(item.civact) - \(item.civdescact)] Solicitado: [\(item.civsol) - \(item.civdescsol)]" + salto
        }
        if item.notaact != item.notasol {
            otroscampos += "Notas actuales: [\(item.notaact)] Solicitado: [\(item.notasol)]" + salto
        }
        if item.licact != item.licsol {
            otroscampos += "Licencia actual: [\(item.licact)] Solicitado: [\(item.licsol)]" + salto
        }
        if item.tipolicact != item.tipolicsol {
            otroscampos += "Tipo licencia actual: [\(item.tipolicact) - \(item.tipolicdescact)] Solicitado: [\(item.tipolicsol) - \(item.tipolicdescsol)]" + salto
        }
        if item.vigact != nil || item.vigsol != nil {
            let vigAct = item.vigact?.date.formatearFecha() ?? ""
            let vigSol = item.vigsol?.date.formatearFecha() ?? ""
            otroscampos += "Vigencia actual: [\(vigAct)] Solicitado: [\(vigSol)]" + salto
        }
        if item.umfact != item.umfsol {
            otroscampos += "UMF actual: [\(item.umfact)] Solicitado: [\(item.umfsol)]" + salto
        }
        if item.semjoract != item.semjorsol {
            otroscampos += "Semana jornada reducida actual: [\(item.semjoract)] Solicitado: [\(item.semjorsol) - \(item.semjordescsol)]" + salto
        }
        if item.fechareact != nil || item.fecharesol != nil {
            let freAct = item.fechareact?.date.formatearFecha() ?? ""
            let freSol = item.fecharesol?.date.formatearFecha() ?? ""
            otroscampos += "Fecha reingreso actual: [\(freAct)] Solicitado: [\(freSol)]" + salto
        }
        if item.fechaimsact != nil || item.fechaimssol != nil {
            let imssAct = item.fechaimsact?.date.formatearFecha() ?? ""
            let imssSol = item.fechaimssol?.date.formatearFecha() ?? ""
            otroscampos += "Fecha alta IMSS actual: [\(imssAct)] Solicitado: [\(imssSol)]" + salto
        }
        if item.regsalminact != item.regsalminsol {
            otroscampos += "Región salario mínimo actual: [\(item.regsalminact) - \(item.regsalmindescact)] Solicitado: [\(item.regsalminsol) - \(item.regsalmindescsol)]" + salto
        }
        if item.folioact != item.foliosol {
            otroscampos += "Folio credencial actual: [\(item.folioact)] Solicitado: [\(item.foliosol)]" + salto
        }
        if item.asegact != item.asegsol {
            otroscampos += "Asegurado IMSS actual: [\(item.asegact)] Solicitado: [\(item.asegsol)]" + salto
        }
        if item.udnact != item.udnsol {
            otroscampos += "Unidad de negocio actual: [\(item.udnact)] Solicitado: [\(item.udnsol)]" + salto
        }
        if item.bancoact != item.bancosol {
            otroscampos += "Banco actual: [\(item.bancoact) - \(item.bancodescact)] Solicitado: [\(item.bancosol) - \(item.bancodescsol)]" + salto
        }
        if item.cheqact != item.cheqsol {
            otroscampos += "Chequera actual: [\(item.cheqact)] Solicitado: [\(item.cheqsol)]" + salto
        }
        if item.nompadreact != item.nompadresol {
            otroscampos += "Nombre del padre actual: [\(item.nompadreact)] Solicitado: [\(item.nompadresol)]" + salto
        }
        if item.nommadreact != item.nommadresol {
            otroscampos += "Nombre de la madre actual: [\(item.nommadreact)] Solicitado: [\(item.nommadresol)]" + salto
        }
        let fechaJubAct = item.fechajubact?.date.formatearFecha() ?? ""
        let fechaJubSol = item.fechajubsol?.date.formatearFecha() ?? ""
        if !fechaJubAct.isEmpty || !fechaJubSol.isEmpty {
            otroscampos += "Fecha jubilación actual: [\(fechaJubAct)] Solicitado: [\(fechaJubSol)]" + salto
        }
        if item.foliojubact != item.foliojubsol {
            otroscampos += "Folio jubilación actual: [\(item.foliojubact)] Solicitado: [\(item.foliojubsol)]" + salto
        }
        if item.porcjubact != item.porcjubsol {
            otroscampos += "Porcentaje jubilación actual: [\(item.porcjubact)] Solicitado: [\(item.porcjubsol)]" + salto
        }
        let tienePenAct = item.pensact == 1
        let tienePenSol = item.penssol == 1
        let procesaPension = item.pensact != item.penssol || tienePenAct || tienePenSol
        if procesaPension {
            otroscampos += "Tiene pensión actual: [\(item.pensact)] Solicitado: [\(item.penssol)]" + salto
            if item.porcalimact != item.porcalimsol {
                otroscampos += "Porc. pensión alimenticia actual: [\(item.porcalimact)] Solicitado: [\(item.porcalimsol)]" + salto
            }
            if item.porcalim2act != item.porcalim2sol {
                otroscampos += "Porc. pensión alimenticia 2 actual: [\(item.porcalim2act)] Solicitado: [\(item.porcalim2sol)]" + salto
            }
            if item.porcalim3act != item.porcalim3sol {
                otroscampos += "Porc. pensión alimenticia 3 actual: [\(item.porcalim3act)] Solicitado: [\(item.porcalim3sol)]" + salto
            }
            if item.imppenact != item.imppensol {
                otroscampos += "Importe pensión actual: [$\(item.imppenact)] Solicitado: [$\(item.imppensol)]" + salto
            }
            if item.imppen2act != item.imppen2sol {
                otroscampos += "Importe pensión 2 actual: [$\(item.imppen2act)] Solicitado: [$\(item.imppen2sol)]" + salto
            }
            if item.imppen3act != item.imppen3sol {
                otroscampos += "Importe pensión 3 actual: [$\(item.imppen3act)] Solicitado: [$\(item.imppen3sol)]" + salto
            }
            if item.descpenalimact != item.descpenalimsol {
                otroscampos += "Descripción pensión actual: [\(item.descpenalimact)] Solicitado: [\(item.descpenalimsol)]" + salto
            }
            if item.descpenalim2act != item.descpenalim2sol {
                otroscampos += "Descripción pensión 2 actual: [\(item.descpenalim2act)] Solicitado: [\(item.descpenalim2sol)]" + salto
            }
            if item.descpenalim3act != item.descpenalim3sol {
                otroscampos += "Descripción pensión 3 actual: [\(item.descpenalim3act)] Solicitado: [\(item.descpenalim3sol)]" + salto
            }
            if item.folpenact != item.folpensol {
                otroscampos += "Folio pensión actual: [\(item.folpenact)] Solicitado: [\(item.folpensol)]" + salto
            }
            if item.folpen2act != item.folpen2sol {
                otroscampos += "Folio pensión 2 actual: [\(item.folpen2act)] Solicitado: [\(item.folpen2sol)]" + salto
            }
            if item.folpen3act != item.folpen3sol {
                otroscampos += "Folio pensión 3 actual: [\(item.folpen3act)] Solicitado: [\(item.folpen3sol)]" + salto
            }
        }
        if item.sindact != item.sindsol {
            otroscampos += "Es sindicalizado actual: [\(item.sindact)] Solicitado: [\(item.sindsol)]" + salto
        }
        if item.cuotasindact != item.cuotasindsol {
            otroscampos += "Cuota sindical actual: [\(item.cuotasindact)] Solicitado: [\(item.cuotasindsol)]" + salto
        }
        if item.tipocuentact != item.tipocuentsol {
            otroscampos += "Tipo cuenta actual: [\(item.tipocuentact)] Solicitado: [\(item.tipocuentsol)]" + salto
        }
        if item.emailact != item.emailsol {
            otroscampos += "Email actual: [\(item.emailact)] Solicitado: [\(item.emailsol)]" + salto
        }
        if item.emailempact != item.emailempsol {
            otroscampos += "Email de la empresa actual: [\(item.emailempact)] Solicitado: [\(item.emailempsol)]" + salto
        }
        if item.regcontact != item.regcontsol {
            otroscampos += "Regimen contratación actual: [\(item.regcontact)] Solicitado: [\(item.regcontsol)]" + salto
        }
        if item.tipcontsatact != item.tipcontsatsol {
            otroscampos += "Tipo contrato SAT actual: [\(item.tipcontsatact) - \(item.tipocontsatdescact)] Solicitado: [\(item.tipcontsatsol) - \(item.tipocontsatdescsol)]" + salto
        }
        if item.tipojornsatact != item.tipojornsatsol {
            otroscampos += "Tipo jornada SAT actual: [\(item.tipojornsatact) - \(item.tipojornsatdescact)] Solicitado: [\(item.tipojornsatsol) - \(item.tipojornsatdescsol)]" + salto
        }
        if item.tiporegsatact != item.tiporegsatsol {
            otroscampos += "Tipo régimen SAT actual: [\(item.tiporegsatact) - \(item.tiporegsatdescact)] Solicitado: [\(item.tiporegsatsol) - \(item.tiporegsatdescsol)]" + salto
        }
        if item.edosatact != item.edosatsol {
            otroscampos += "Estado SAT actual: [\(item.edosatact) - \(item.edosatdescact)] Solicitado: [\(item.edosatsol) - \(item.edosatdescsol)]" + salto
        }
        if item.puesimsact != item.puesimssol {
            otroscampos += "Puesto Id IMSS actual: [\(item.puesimsact) - \(item.puesimsdescact)] Solicitado: [\(item.puesimssol) - \(item.puesimsdescsol)]" + salto
        }
        if item.escact != item.escsol {
            otroscampos += "Escolaridad Actual: [\(item.escact) - \(item.escdescact)] Solicitado: [\(item.escsol) - \(item.escdescsol)]" + salto
        }
        if item.uniact != item.unisol {
            otroscampos += "Carrera universitaria actual: [\(item.uniact)] Solicitado: [\(item.unisol)]" + salto
        }
        if item.estactact != item.estactsol {
            otroscampos += "Estudia actualmente actual: [\(item.estactact)] Solicitado: [\(item.estactsol)]" + salto
        }
        if item.queestact != item.queestsol {
            otroscampos += "Qué estudia actual: [\(item.queestact)] Solicitado: [\(item.queestsol)]" + salto
        }
        if item.medestact != item.medestsol {
            otroscampos += "Medio de estudio actual: [\(item.medestact) - \(item.medestdescact)] Solicitado: [\(item.medestsol) - \(item.medestdescsol)]" + salto
        }
        if item.condvivact != item.condvivsol {
            otroscampos += "Condiciones de vivienda actual: [\(item.condvivact) - \(item.condvivdescact)] Solicitado: [\(item.condvivsol) - \(item.condvivdescsol)]" + salto
        }
        if item.viveact != item.vivesol {
            otroscampos += "Con quién vive actual: [\(item.viveact) - \(item.vivedescact)] Solicitado: [\(item.vivesol) - \(item.vivedescsol)]" + salto
        }
        if item.nomconyuact != item.nomconyusol {
            otroscampos += "Nombre del cónyuge actual: [\(item.nomconyuact)] Solicitado: [\(item.nomconyusol)]" + salto
        }
        if item.canthijosact != item.canthijossol {
            otroscampos += "Cantidad de hijos actual: [\(item.canthijosact)] Solicitado: [\(item.canthijossol)]" + salto
        }
        if item.nomhijoact != item.nomhijosol {
            otroscampos += "Nombre del hijo 1 actual: [\(item.nomhijoact)] Solicitado: [\(item.nomhijosol)]" + salto
        }
        if item.edadhijoact != item.edadhijosol {
            otroscampos += "Edad del hijo 1 actual: [\(item.edadhijoact)] Solicitado: [\(item.edadhijosol)]" + salto
        }
        if item.hijoescact != item.hijoescsol {
            otroscampos += "Hijos en edad escolar actual: [\(item.hijoescact)] Solicitado: [\(item.hijoescsol)]" + salto
        }
        if item.numdepecact != item.numdepecsol {
            otroscampos += "Número de dependientes económicos actual: [\(item.numdepecact)] Solicitado: [\(item.numdepecsol)]" + salto
        }
        if item.enfcroact != item.enfcrosol {
            otroscampos += "Tiene enfermedad crónica actual: [\(item.enfcroact)] Solicitado: [\(item.enfcrosol)]" + salto
        }
        if item.nomenfcroact != item.nomenfcrosol {
            otroscampos += "Nombre de la enfermedad crónica actual: [\(item.nomenfcroact)] Solicitado: [\(item.nomenfcrosol)]" + salto
        }
        if item.segvidaact != item.segvidasol {
            otroscampos += "Tiene seguro de vida actual: [\(item.segvidaact)] Solicitado: [\(item.segvidasol)]" + salto
        }
        if item.nombensegvidaact != item.nombensegvidasol {
            otroscampos += "Beneficiario del seguro de vida actual: [\(item.nombensegvidaact)] Solicitado: [\(item.nombensegvidasol)]" + salto
        }
        if item.montoasegact != item.montoasegsol {
            otroscampos += "Monto asegurado actual: [\(item.montoasegact)] Solicitado: [\(item.montoasegsol)]" + salto
        }
        if item.seggastosact != item.seggastossol {
            otroscampos += "Seguro de gastos médicos mayores actual: [\(item.seggastosact)] Solicitado: [\(item.seggastossol)]" + salto
        }
        if item.nombecimact != item.nombecimsol {
            otroscampos += "Beneficiarios SGMM actual: [\(item.nombecimact)] Solicitado: [\(item.nombecimsol)]" + salto
        }
        if item.nomemgact != item.nomemgsol {
            otroscampos += "Persona de emergencia actual: [\(item.nomemgact)] Solicitado: [\(item.nomemgsol)]" + salto
        }
        if item.bengasact != item.bengassol {
            otroscampos += "Beneficio gas sin cargo actual: [\(item.bengasact)] Solicitado: [\(item.bengassol)]" + salto
        }
        if item.bencomact != item.bencomsol {
            otroscampos += "Beneficio comedor actual: [\(item.bencomact)] Solicitado: [\(item.bencomsol)]" + salto
        }
        if item.bentraact != item.bentrasol {
            otroscampos += "Beneficio transporte actual: [\(item.bentraact)] Solicitado: [\(item.bentrasol)]" + salto
        }
        if item.benmamact != item.benmamsol {
            otroscampos += "Beneficio mamá actual: [\(item.benmamact)] Solicitado: [\(item.benmamsol)]" + salto
        }
        if item.benpapact != item.benpapsol {
            otroscampos += "Beneficio papá actual: [\(item.benpapact)] Solicitado: [\(item.benpapsol)]" + salto
        }
        if item.bendianinoact != item.bendianinosol {
            otroscampos += "Beneficio día del niño actual: [\(item.bendianinoact)] Solicitado: [\(item.bendianinosol)]" + salto
        }
        if item.suelreact != item.suelresol {
            otroscampos += "Sueldo diario real actual: [$\(item.suelreact)] Solicitado: [$\(item.suelresol)]" + salto
        }
        if item.bandepact != item.bandepsol {
            otroscampos += "Banco depósito actual: [\(item.bandepact) - \(item.bandepdescact)] Solicitado: [\(item.bandepsol) - \(item.bandepdescsol)]" + salto
        }
        if item.claintdepact != item.claintdepsol {
            otroscampos += "CLABE interbancaria actual: [\(item.claintdepact)] Solicitado: [\(item.claintdepsol)]" + salto
        }
        if item.suelimpenact != item.suelimpensol {
            otroscampos += "Sueldo real IMSS por pensión actual: [$\(item.suelimpenact)] Solicitado: [$\(item.suelimpensol)]" + salto
        }
        if item.razpatact != item.razpatsol {
            otroscampos += "Razón social patronal actual: [\(item.razpatact)] Solicitado: [\(item.razpatsol)]" + salto
        }
        if item.empcompact != item.empcompsol {
            otroscampos += "Empresa complemento de nómina actual: [\(item.empcompact)] Solicitado: [\(item.empcompsol)]" + salto
        }
        let tieneFonAct = item.fonact == 1
        let tieneFonSol = item.fonsol == 1
        let procesaFonacot = item.fonact != item.fonsol || tieneFonAct || tieneFonSol
        if procesaFonacot {
            otroscampos += "Tiene Fonacot actual: [\(item.fonact)] Solicitado: [\(item.fonsol)]" + salto
            if item.numfonact != item.numfonsol {
                otroscampos += "Número crédito Fonacot actual: [\(item.numfonact)] Solicitado: [\(item.numfonsol)]" + salto
            }
            if item.fechainifonact != nil || item.fechainifonsol != nil {
                let fechaActual = item.fechainifonact?.date.formatearFecha() ?? ""
                let fechaSolicitado = item.fechainifonsol?.date.formatearFecha() ?? ""
                otroscampos += "Fecha inicio descuento Fonacot actual: [\(fechaActual)] Solicitado: [\(fechaSolicitado)]" + salto
            }
            if item.impfonact != item.impfonsol {
                otroscampos += "Importe descuento Fonacot actual: [\(item.impfonact)] Solicitado: [\(item.impfonsol)]"
            }
        }
        return otroscampos
    }
}
struct filaTablaPersonal: View {
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
