//
//  SolicitudLiquidacionView.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//
import SwiftUI
import Foundation

struct SolicitudLiquidacionView: View {
    @Environment(\.dismiss) private var dismiss
    let liq: DatosLiquidacion
    private let columnas: [GridItem] = [
        GridItem(.fixed(150), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    private let alto: CGFloat = 45
    struct filaTabla: Identifiable {
        let id = UUID()
        let titulo: String
        let valor: String
        let multilinea: Bool
    }
    private var filas: [filaTabla] {
        [
            .init(titulo: "Empresa", valor: liq.id.siglasEmpresaLiq, multilinea: true),
            .init(titulo: "Fecha de venta", valor: liq.fecha.date.formatearFechaHora(), multilinea: false),
//            .init(
//                titulo: "Estación/Vehículo",
//                valor: liq.alm == "0" ? liq.veh : liq.alm,
//                multilinea: false
//            ),
            .init(
                titulo: "Estación/Vehículo",
                valor: !liq.veh.trimmingCharacters(in: .whitespaces).isEmpty
                    ? liq.veh
                    : (!liq.alm.trimmingCharacters(in: .whitespaces).isEmpty ? liq.alm : "-"),
                multilinea: false
            ),
            .init(
                titulo: "Cliente",
                valor: "\(liq.cliente) - \(liq.nom_cliente)",
                multilinea: true
            ),
            .init(
                titulo: "Contrato",
                valor: "\(String(liq.contrato)) - \(liq.nom_contrato)",
                multilinea: true
            ),
            .init(
                titulo: "Ticket",
                valor: "\(liq.serie)\(String(liq.folio))",
                multilinea: false
            ),
            .init(titulo: "Cantidad", valor: liq.cantidad, multilinea: false),
            .init(titulo: "Precio", valor: "$\(liq.precio)", multilinea: true),
            .init(titulo: "Total", valor: "$\(liq.total)", multilinea: false),
            .init(
                titulo: "Solicitud",
                valor: "\(liq.tipo) - \(liq.solicitud)",
                multilinea: true
            ),
            .init(titulo: "Solicitante", valor: liq.solicitante, multilinea: true),
            // Comentarios: multilinea
            .init(
                titulo: "Comentarios",
                valor: liq.comentarios.isEmpty ? "-" : liq.comentarios,
                multilinea: true
            )
        ]
    }
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
                            LazyVGrid(columns: columnas, spacing: 0) {
                                ForEach(filas) { fila in
                                    /*Text(fila.titulo)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                        .frame(height: fila.multilinea ? nil : alto)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.vertical, fila.multilinea ? 8 : 0)
                                        .background(Color("Blue1"))*/
                                    Group {
                                        if fila.multilinea {
                                            Text(fila.titulo)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(.white)
                                                .frame(height: fila.multilinea ? nil : alto)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .padding(.vertical, fila.multilinea ? 8 : 0)
                                                .background(Color("Blue1"))
                                            Text(fila.valor)
                                                .font(.system(size: 16,))
                                                .foregroundColor(.black)
                                                .frame(height: fila.multilinea ? nil : alto)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .fixedSize(horizontal: false, vertical: true)
                                        } else {
                                            Text(fila.titulo)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(.white)
                                                .frame(height: fila.multilinea ? nil : alto)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .padding(.vertical, fila.multilinea ? 8 : 0)
                                                .background(Color("Blue1"))
                                            Text(fila.valor)
                                                .font(.system(size: 16))
                                                .foregroundColor(.black)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .frame(height: fila.multilinea ? nil : alto)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .background(Color("WhiteBG"))
                                }
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
                                        .background(Color("Green1"))
                                        .cornerRadius(25)
                                }
                                Button(action: {
                                    print("Rechazar")
                                }) {
                                    Text("Rechazar")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(width: 130, height: 45)
                                        .background(Color("Red1"))
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
enum EmpresaId: Int {
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
        case .pac: return "Vendogas Pacífico"
        case .pmil: return "Vendogas Pacífico Milenium"
        }
    }
}
extension Int {
    var siglasEmpresaLiq: String {
        EmpresaId(rawValue: self)?.siglas ?? "N/D"
    }
}
