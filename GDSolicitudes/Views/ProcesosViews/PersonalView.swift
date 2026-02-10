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
                                            let detalle = detalleAdicional(item)
                                            if !detalle.isEmpty {
                                                Text(detalle)
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(Color("Red"))
                                                    .padding(.bottom, 10)
                                            }
                                            //MARK: Detalles generales
                                            VStack(alignment: .leading, spacing: 6) {
                                                let feccad = item.fechacad.date.formatearFecha()
                                                filaTablaPlantilla(titulo: "Solicitud", valor: "\(solicitudID)")
                                                Divider()
                                                filaTablaPlantilla(titulo: "Datos Actuales/Solicitados", valor: otrosCampos(item))
                                                Divider()
                                                filaTablaPlantilla(titulo: "Fecha caducidad", valor: feccad)
                                                filaTablaPlantilla(titulo: "Solicitante", valor: "\(item.solicitante)")
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
                .frame(width: 380, height: 760, alignment: .top)
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
        ClienteAPI.obtenerPersonal(solicitud: solicitudID) { result in
            cargando = false
            switch result {
            case .success(let arr):
                self.datos = arr.data
            case .failure(let error):
                self.errorMsg = "Error: \(error.localizedDescription)"
            }
        }
    }
    func detalleAdicional(_ item: Personal) -> String {
        if (item.nuevo == 1) {
            "Alta de personal"
        } else if (item.soltemp == 1) {
            "Alta de personal, con puesto temporal"
        } else if (item.famempsol == 1) {
            "Alta de personal, con familiar en la empresa"
        } else if (item.contcompsol == 1) {
            "Alta de personal, viene de competencia"
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
            otroscampos += "Contratación competencia actual: [\(contcompact))] Solicitado: [\(contcompsol)]" + salto
        }
        let famact = if(item.contcompact == 1) { "SI" } else {"NO"}
        let famsol = if(item.contcompsol == 1) { "SI" } else {"NO"}
        otroscampos += "Familiares en la empresa actual: [\(famact)] Solicitado: [\(famsol)]" + salto
        if item.soltemp == 1 {
            let fechatempini = item.fechatempini?.date.formatearFecha()
            let fechatempfin = item.fechatempfin?.date.formatearFecha()
            otroscampos += "Puesto temporal desde: \(fechatempini ?? "") Hasta: \(fechatempfin ?? "")"
        } else {
            otroscampos += "Puesto temporal N/A"
        }
        let nombreact = "\(item.nomact) \(item.apepatact) \(item.apematact)"
        let nombresol = "\(item.nomsol) \(item.apepatsol) \(item.apematsol)"
        otroscampos += "Nombre Actual: [\(nombreact)] Solicitado: [\(nombresol)]"
        otroscampos += "Puesto Actual: [\(item.puestoact) - \(item.puestodescact)] Solicitado: [\(item.puestosol) - \(item.puestodescsol)]"
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
            otroscampos += "Tipo de contrato actual: [\(item.tipocontact) - \(item.tipocontdescact)] Solicitado: [\(item.tipocontsol) - \(item.tipocontdescsol)]" + salto
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
            otroscampos += "País Actual: [\(item.paissatact) - \(item.paissatactdesc)] Solicitado: [\(item.paissatsol) - \(item.paissatsoldesc)]" + salto
        }
        if item.edosatidact != item.edosatidsol {
            otroscampos += "Estado Actual: [\(item.edosatidact) - \(item.edosatidactdesc)] Solicitado: [\(item.edosatidsol) - \(item.edosatidsoldesc)]" + salto
        }
        if item.munsatact != item.munsatsol {
            otroscampos += "Municipio Actual: [\(item.munsatact) - \(item.munsatactdesc)] Solicitado: [\(item.munsatsol) - \(item.munsatsoldesc)]" + salto
        }
        if item.locsatact != item.locsatsol {
            otroscampos += "Localidad Actual: [\(item.locsatact) - \(item.locsatactdesc)] Solicitado: [\(item.locsatsol) - \(item.locsatsoldesc)]" + salto
        }
        if item.colsatact != item.colsatsol {
            otroscampos += "Colonia Actual: [\(item.colsatact) - \(item.colsatactdesc)] Solicitado: [\(item.colsatsol) - \(item.colsatsoldesc)]" + salto
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
            otroscampos += "Categoría de comisiones actual: [\(item.catcomact) - \(item.catcomdescact)] Solicitado: [\(item.catcomsol) - \(item.catcomdescsol)]" + salto
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
        if item.privasiact != item.privasissol {
            otroscampos += "Privilegio asistencia actual: [\(item.privasiact)] Solicitado: [\(item.privasissol)]" + salto
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
            otroscampos += "Sueldo diario IMSS actual: [\(item.sueldoimssact)] Solicitado: [\(item.sueldoimsssol)]" + salto
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
            otroscampos += "Salario bimestral anterior actual: [\(item.salbiantact)] Solicitado: [\(item.salbiantsol)]" + salto
        }
        let tieneInfoAct = item.infoact == 1
        let tieneInfoSol = item.infosol == 1
        let procesaInfonavit = item.infoact != item.infosol || tieneInfoAct || tieneInfoSol
        if procesaInfonavit {
            otroscampos += "Tiene Infonavit actual: [\(tieneInfoAct ? "SI" : "NO")] Solicitado: [\(tieneInfoSol ? "SI" : "NO")]" + salto
            if item.amoract != item.amorsol {
                otroscampos += "Infonavit - Tipo amortización actual: [\(item.amoract) - \(item.amordescact)] Solicitado: [\(item.amorsol) - \(item.amordescsol)]" + salto
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
        return otroscampos
    }
}
struct filaTablaPersonal: View {
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
