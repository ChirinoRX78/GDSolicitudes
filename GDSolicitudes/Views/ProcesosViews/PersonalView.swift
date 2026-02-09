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
        let fechatempini = item.fechatempini?.date.formatearFecha()
        let fechatempfin = item.fechatempfin?.date.formatearFecha()
        let contcompact = if(item.contcompact == 1) { "SI" } else {"NO"}
        let contcompsol = if(item.contcompsol == 1) { "SI" } else {"NO"}
        let famact = if(item.contcompact == 1) { "SI" } else {"NO"}
        let famsol = if(item.contcompsol == 1) { "SI" } else {"NO"}
        let nombreact = "\(item.nomact) \(item.apepatact) \(item.apematact)"
        let nombresol = "\(item.nomsol) \(item.apepatsol) \(item.apematsol)"
        let salto = "\n"
        var otroscampos = "Categoría del puesto [\(item.catpers) - \(item.catpersdesc)]" + salto
        if (item.contcompact != item.contcompsol) {
            otroscampos += "Contratación competencia actual: [\(contcompact))] Solicitado: [\(contcompsol)]" + salto
            /*if (!item.fechatempini.date.isEmpty && !item.fechatempfin.date.isEmpty) {
                otroscampos += "Puesto temporal desde: [\(fechatempini)] Hasta: [\(fechatempfin)]"
            }*/
        }
        otroscampos += "Familiares en la empresa actual: [\(famact)] Solicitado: [\(famsol)]" + salto
        if (item.soltemp == 1) {
            otroscampos += "Puesto temporal desde: \(fechatempini ?? "") Hasta: \(fechatempfin ?? "")"
        } else {
            otroscampos += "Puesto temporal N/A"
        }
        otroscampos += "Nombre Actual: [\(nombreact)] Solicitado: [\(nombresol)]"
        otroscampos += "Puesto Actual: [\(item.puestoact) - \(item.puestodescact)] Solicitado: [\(item.puestosol) - \(item.puestodescsol)]"
        //if (item.)
        /*if (item.puestodescact != item.puestodescsol) {
            otroscampos += "Descripción corta actual: [\(item.puestodescact)] Solicitado: [\(item.puestodescsol)]" + salto
        }
        if (item.puestodescactlarga != item.puestodescsollarga) {
            otroscampos += "Descripción larga actual: [\(item.puestodescactlarga)] Solicitado: [\(item.puestodescsollarga)]" + salto
        }
        if (item.areadescact != item.areadescsol) {
            otroscampos += "Área actual: [\(item.areact) - \(item.areadescact)] Solicitado: [\(item.aresol) - \(item.areadescsol)]" + salto
        }
        if (item.puestopadredescact != item.puestopadredescsol) {
            otroscampos += "Depende De, Actual: [\(item.puestopadreact) - \(item.puestopadredescact)] Solicitado: [\(item.puestopadresol) - \(item.puestopadredescsol)]" + salto
        }
        if (item.edadminact != item.edadminsol) {
            otroscampos += "Edad mínima actual: [\(item.edadminact)] Solicitado: [\(item.edadminsol)]" + salto
        }
        if (item.edadmaxact != item.edadmaxsol) {
            otroscampos += "Edad máxima actual: [\(item.edadmaxact)] Solicitado: [\(item.edadmaxsol)]" + salto
        }
        if (item.sexoact != item.sexosol) {
            otroscampos += "Género actual: [\(item.sexoact) - \(item.sexodescact)] Solicitado: [\(item.sexosol) - \(item.sexodescsol)]" + salto
        }
        if (item.civilact != item.civilsol) {
            otroscampos += "Estado civil actual: [\(item.civilact) - \(item.civildescact)] Solicitado: [\(item.civilsol) - \(item.civildescsol)]" + salto
        }
        if (item.escact != item.escsol) {
            otroscampos += "Nivel de escolaridad actual: [\(item.escact) - \(item.escdescact)] Solicitado: [\(item.escsol) - \(item.escdescsol)]" + salto
        }
        if (item.otrosact != item.otrossol) {
            otroscampos += "Otros estudios actual: [\(item.otrosact)] Solicitado: [\(item.otrossol)]" + salto
        }
        if (item.riesgoact != item.riesgosol) {
            otroscampos += "Riesgo de puesto actual: [\(item.riesgoact) - \(item.riesgodescact)] Solicitado: [\(item.riesgosol) - \(item.riesgodescsol)]" + salto
        }
        if (item.puestoimact != item.puestoimsol) {
            otroscampos += "Puesto IMSS actual: [\(item.puestoimact) - \(item.puestoimmdescact)] Solicitado: [\(item.puestoimsol) - \(item.puestoimmdescsol)]" + salto
        }
        if (item.cattipodescact != item.cattipodescsol) {
            otroscampos += "Categoría tipos de personal actual: [\(item.cattipodescact) - \(item.cattipodescdescact)] Solicitado: [\(item.cattipodescsol) - \(item.cattipodescdescsol)]" + salto
        }
        if (item.objact != item.objsol) {
            otroscampos += "Objetivo general actual: [\(item.otrosact)] Solicitado: [\(item.otrossol)]" + salto
        }
        */
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
