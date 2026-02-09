//
//  SolicitudWorkflowView.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//
import SwiftUI
import Foundation

struct SolicitudWorkflowView: View {
    @Environment(\.dismiss) private var dismiss
    let wf: DatosWorkflow
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
                VStack(spacing: 0) {
                    //MARK: Tabla
                    ScrollView {
                        VStack(spacing: 0) {
                            Text(wf.descripcion)
                                .font(.title2.bold())
                                .foregroundColor(Color("Blue1"))
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
                            .padding(.top, 20)
                        }
                    }
                }
                .padding()
                .frame(width: 380, height: 760, alignment: .top)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 6)
                .offset(y: 90)
            }
        }
    }
}
enum EmpresaNombre: Int {
    case dam = 1
    case tab = 2
    case ven = 3
    case mil = 4
    case nan = 5
    case tri = 7
    case tda = 8
    case gen = 12
    case pac = 14
    case pmil = 37
    var siglas: String {
        switch self {
        case .dam: return "Damigas"
        case .tab: return "Tabagas"
        case .ven: return "Vendogas"
        case .mil: return "Gas Milenium"
        case .nan: return "Vendogas Nanchital"
        case .tri: return "Vendogas Trinitaria"
        case .tda: return "Transportes D'Amiano"
        case .gen: return "Generadores de Energía del Noroeste"
        case .pac: return "Vendogas del Pacífico"
        case .pmil: return "Vendogas del Pacífico Milenium"
        }
    }
}
extension Int {
    var siglasEmpresaWf: String {
        EmpresaNombre(rawValue: self)?.siglas ?? "N/D"
    }
}
