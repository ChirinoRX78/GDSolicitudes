//
//  HomeView.swift
//  TestWF
//
//  Created by TI on 09/01/26.
//

import SwiftUI
import Foundation

struct HomeView: View {
    let usuario: String
    //JSON con stored
    @State private var usuarioInfo: DatosUsuario?
    @State private var workflow: [DatosWorkflow] = []
    @State private var liquidacion: [DatosLiquidacion] = []
    @State private var cargando = true
    @State private var mensajeError: String?
    //Animaciones
    @State private var mostrarCartaWorkflow = false
    @State private var mostrarCartaLiquidacion = false
    @State private var animarCartas = false
    @State private var mostrarContenido = false
    @State private var mostrarSettings = false
    //Cierre de sesión
    @State private var mostrarCierre = false
    //Carga de solicitudes
    @State private var respuestaAPI: RespuestaAPI?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State private var path: [WfRoute] = []
    var body: some View {
        NavigationView {
            ZStack {
                Color("WhiteBG")
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        GeometryReader { geo in
                            Rectangle()
                                .fill(Color("Blue1"))
                                .frame(height: geo.safeAreaInsets.top)
                                .edgesIgnoringSafeArea(.top)
                        }
                        HStack(spacing: 5) {
                            Image("newLogo")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.leading, 20)
                            Text("Grupo D'Amiano")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                            Spacer()
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 20)
                                    .font(.system(size: 20, weight: .bold))
                            }
                            Button(action: {
                                mostrarCierre = true
                            }) {
                                Image(systemName: "power")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 30)
                                    .font(.system(size: 20, weight: .bold))
                            }
                        }
                        .padding(10)
                        .frame(width: 405, height: 120, alignment: .center)
                        .background(Color("Blue1"))
                        .clipShape (
                            bordesRedondo(
                                radio: 30,
                                esquina: [.bottomLeft, .bottomRight])
                        )
                        VStack(alignment: .leading, spacing: 10) {
                            ZStack(alignment: .leading) {
                                if let nombre = usuarioInfo?.name {
                                        Text(nombre)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(Color("Blue1"))
                                            .transition(.opacity.combined(with: .move(edge: .top)))
                                    } else {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color("Blue1").opacity(0.2))
                                            .frame(width: 300, height: 22)
                                            .redacted(reason: .placeholder)
                                    }
                            }
                            .animation(.easeInOut(duration: 0.5), value: usuarioInfo?.name)
                            .padding(.leading, 5)
                            .frame(height: 26, alignment: .leading)
                            Text("Seleccione el tipo de solicitud a autorizar:")
                                .font(.system(size: 16, design: .default))
                                .foregroundColor(Color.black)
                                .padding(.leading, 5)
                            HStack(spacing: 10){
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        mostrarCartaWorkflow.toggle()
                                        mostrarCartaLiquidacion = false
                                        animarCartas = mostrarCartaWorkflow
                                    }
                                    if mostrarCartaWorkflow, let response = respuestaAPI {
                                        workflow = Array(response.workflow.values)
                                    }
                                }) {
                                    Text("Workflow")
                                        .padding(13)
                                        .font(.system(size: 16, weight: .semibold, design: .default))
                                        .frame(width: 120)
                                        .foregroundColor(mostrarCartaWorkflow ? .white : Color("Blue1"))
                                        .background(mostrarCartaWorkflow ? Color("Blue1"): .clear)
                                        .cornerRadius(25)
                                }
                                .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("Blue1"), lineWidth: 2))
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        mostrarCartaLiquidacion.toggle()
                                        mostrarCartaWorkflow = false
                                        animarCartas = mostrarCartaLiquidacion
                                    }
                                    if mostrarCartaLiquidacion, let response = respuestaAPI {
                                        liquidacion = Array(response.liquidacion.values)
                                    }
                                }) {
                                    Text("Liquidación")
                                        .padding(13)
                                        .font(.system(size: 16, weight: .semibold, design: .default))
                                        .frame(width: 120)
                                        .foregroundColor(mostrarCartaLiquidacion ? .white : Color("Blue1"))
                                        .background(mostrarCartaLiquidacion ? Color("Blue1"): .clear)
                                        .cornerRadius(25)
                                }
                                .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("Blue1"), lineWidth: 2))
                            }
                        }
                        .padding()
                        .frame(width: 380, height: 150, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 6)
                            .offset(y: 100)
                        
                    }
                    Spacer()
                        .frame(height: 710)
                }
                ZStack {
                    if mostrarCartaWorkflow {
                        cartaWorkflow(workflow: workflow, cargando: cargando, recargar: cargarDatos)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.top, 270)
                            .zIndex(10)
                    }
                    if mostrarCartaLiquidacion {
                        cartaLiquidacion(liquidacion: liquidacion, cargando: cargando, recargar: cargarDatos)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.top, 270)
                            .zIndex(10)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            cargarDatos()
        }
        .alert(isPresented: $mostrarCierre) {
            Alert(
                title: Text("Cerrar sesión"),
                message: Text("¿Desea cerrar la sesión?"),
                primaryButton: .destructive(Text("Si")) {
                    cerrarSesion()
                },
                secondaryButton: .cancel(Text("No"))
            )
        }
    }
    //MARK: Funciones para carga de información
    func cargarDatos() {
        cargando = true
        mensajeError = nil
        ClienteAPI.obtenerInfo(usuario: usuario) { result in
            DispatchQueue.main.async {
                self.cargando = false
                switch result {
                case .success(let response):
                    self.respuestaAPI = response
                    self.usuarioInfo = response.data.first
                    //self.workflow = Array(response.workflow.values)
                    //self.liquidacion = Array(response.liquidacion.values)
                case .failure:
                    mensajeError = "Error de carga."
                }
            }
        }
    }
    func cerrarSesion() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Credenciales.usuario)
        defaults.removeObject(forKey: Credenciales.contrasena)
        defaults.set(false, forKey: Credenciales.recordar)
        presentationMode.wrappedValue.dismiss()
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
//        HomeView(usuario: "admin")
        LoginView()
    }
}
//MARK: Carta liquidación
struct cartaLiquidacion: View {
    let liquidacion: [DatosLiquidacion]
    let cargando: Bool
    let recargar: () -> Void
    @State private var showToast = false
    private let columnasTabla: [GridItem] = [
        GridItem(.fixed(60), alignment: .center), //Empresa
        GridItem(.fixed(70), alignment: .center),   // Fecha
        GridItem(.fixed(80), alignment: .center), // Ticket
        GridItem(.fixed(90), alignment: .center)  // Solicitud
    ]
    var body: some View {
        VStack {
            Text("Solicitudes pendientes")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(Color("Blue1"))
                .frame(maxWidth: .infinity, alignment: .center)
            LazyVGrid(columns: columnasTabla, spacing: 0) {
                Text("Empresa")
                Text("Fecha")
                Text("Ticket")
                Text("Solicitud")
            }
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 10)
            .background(Color("Blue1"))
            if cargando {
                LottieView(name: "cargando", loopMode: .loop)
                    .frame(height: 120)
                    .transition(.opacity)
            } else {
                ScrollView {
                    ForEach(liquidacion) { liq in
                        NavigationLink {
                            SolicitudLiquidacionView(liq: liq)
                        } label: {
                            liquidacionFila(liq: liq)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .refreshable {
                    recargar()
                }
                .tint(Color("Blue1"))
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(width: 380, height: 590)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 6)
        .overlay(
            VStack {
                Spacer()
                if showToast {
                    ToastView(message: "No hay solicitudes pendientes")
                        .padding(.bottom, 50)
                }
            }
        )
            /*.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        cargando = false
                    }
                    if liquidacion.isEmpty {
                        mostrarToast()
                    }
                }
            }*/
        }
        /*private func mostrarToast() {
            withAnimation {
                showToast = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    showToast = false
                }
            }
        }*/
}
//MARK: Carta Workflow
struct cartaWorkflow: View {
    let workflow: [DatosWorkflow]
    let cargando: Bool
    let recargar: () -> Void
    @State private var showToast = false
    private let columnasTabla: [GridItem] = [
        GridItem(.fixed(60), alignment: .center),
        GridItem(.fixed(60), alignment: .center),
        GridItem(.flexible(minimum: 80), alignment: .center),
        GridItem(.fixed(90), alignment: .center)
    ]
    var body: some View {
        VStack {
            Text("Solicitudes pendientes")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(Color("Blue1"))
                .frame(maxWidth: .infinity, alignment: .center)
            LazyVGrid(columns: columnasTabla, spacing: 0) {
                Text("Empresa")
                Text("Solicitud")
                Text("Descripción")
                Text("Solicitante")
            }
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 10)
                .background(Color("Blue1"))
            if cargando {
                LottieView(name: "cargando", loopMode: .loop)
                    .frame(height: 120)
                    .transition(.opacity)
            } else {
                ScrollView {
                    ForEach(workflow) { wf in
                        NavigationLink {
                            destinoProceso(wf)
                        } label: {
                            workflowFila(wf: wf)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .refreshable {
                    recargar()
                }
                .tint(Color("Blue1"))
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(width: 380, height: 590)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 6)
        /*.overlay(
            VStack {
                Spacer()
                    if showToast {
                        ToastView(message: "No hay solicitudes pendientes")
                            .padding(.bottom, 50)
                    }
                }
            )
        .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        cargando = false
                    }
                    if workflow.isEmpty {
                        mostrarToast()
                    }
                }
            }*/
    }
    /*private func mostrarToast() {
        withAnimation {
            showToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                showToast = false
            }
        }
    }*/
    @ViewBuilder
    private func destinoProceso(_ wf: DatosWorkflow) -> some View {
        let proceso =  ProcesoWf(rawValue: wf.procesoId)
        switch proceso {
        case .descuento: DescuentoView(solicitudID: wf.id)
        case .credito: CreditoView(solicitudID: wf.id)
        case .precio: PrecioView(solicitudID: wf.id)
        case .desbloqueo: DesbloqueoView(solicitudID: wf.id)
        case .geocerca: GeocercaView(solicitudID: wf.id)
        case .contrato: ContratoView(solicitudID: wf.id)
        case .ruta: RutaView(solicitudID: wf.id)
        case .creditoclientes: CreditoClientesView(solicitudID: wf.id)
        case .plantilla: PlantillaView(solicitudID: wf.id)
        case .personal: PersonalView(solicitudID: wf.id)
        case .puestos: PuestoView(solicitudID: wf.id)
        case .salario: SalarioView(solicitudID: wf.id)
        case .reingreso: ReingresoView(solicitudID: wf.id)
        case .baja: BajaView(solicitudID: wf.id)
        case .none: NoSoportadoView(procesoID: wf.procesoId, solicitudID: wf.id)
        }
    }
}
//MARK: Fila Liquidación
struct liquidacionFila: View {
    let liq: DatosLiquidacion
    private let columnasTabla: [GridItem] = [
        GridItem(.fixed(60), alignment: .center), //Empresa
        GridItem(.fixed(70), alignment: .center),   // Fecha
        GridItem(.fixed(80), alignment: .center), // Ticket
        GridItem(.fixed(90), alignment: .center)  // Solicitud
    ]
    var body: some View {
        LazyVGrid(columns: columnasTabla, spacing: 0) {
            Text(liq.id.siglasEmpresa)
                .font(.system(size: 13))
                .foregroundColor(.black)
            Text("\(liq.fecha.date.formatearFecha())")
                .font(.system(size: 13))
                .foregroundColor(Color.black)
                .lineLimit(1)
            Text(verbatim: "\(liq.serie)\(String(liq.folio))")
                .font(.system(size: 13))
                .foregroundColor(.black)
                .lineLimit(1)
            Text("\(liq.solicitud)")
                .font(.system(size: 13))
                .foregroundColor(Color.black)
            }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color("Blue1"), lineWidth: 1)
        )
    }
}
//MARK: Fila Workflow
struct workflowFila: View {
    let wf: DatosWorkflow
    private let columnasTabla: [GridItem] = [
        GridItem(.fixed(60), alignment: .center), //Empresa
        GridItem(.fixed(60), alignment: .center),   // Solicitud
        GridItem(.flexible(minimum: 80), alignment: .center), // Descripción
        GridItem(.fixed(90), alignment: .center)  // Solicitante
    ]
    var body: some View {
        LazyVGrid(columns: columnasTabla, spacing: 0) {
            Text(wf.empresaid.siglasEmpresa)
                .font(.system(size: 13))
                .foregroundColor(.black)
            Text(verbatim: String(wf.id))
                .font(.system(size: 13))
                .foregroundColor(.black)
            Text("\(wf.descripcion)")
                .font(.system(size: 13))
                .foregroundColor(.black)
            Text("\(wf.solicitanteID)")
                .font(.system(size: 13))
                .foregroundColor(.black)
                .lineLimit(1)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color("Blue1"), lineWidth: 1)
        )
    }
}
//MARK: Funciones extra
struct bordesRedondo: Shape {
    var radio: CGFloat = .infinity
    var esquina: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: esquina,
            cornerRadii: CGSize(width: radio, height: radio)
        )
        return Path(path.cgPath)
    }
}
extension String {
    func formatearFecha() -> String {
        let formatterEntrada = DateFormatter()
        formatterEntrada.locale = Locale(identifier: "es-MX")
        formatterEntrada.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        let formatterSalida = DateFormatter()
        formatterSalida.locale = Locale(identifier: "es-MX")
        formatterSalida.dateFormat = "dd/MM/yyyy"
        if let fecha = formatterEntrada.date(from: self) {
            return formatterSalida.string(from: fecha)
        }
        return self
    }
    func formatearFechaHora() -> String {
        let formatterEntrada = DateFormatter()
        formatterEntrada.locale = Locale(identifier: "es-MX")
        formatterEntrada.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        let formatterSalida = DateFormatter()
        formatterSalida.locale = Locale(identifier: "es-MX")
        formatterSalida.dateFormat = "dd/MM/yyyy HH:mm:ss a"
        if let fecha = formatterEntrada.date(from: self) {
            return formatterSalida.string(from: fecha).lowercased()
        }
        return self
    }
}
enum Empresa: Int {
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
        case .dam: return "DAM"
        case .tab: return "TAB"
        case .ven: return "VEN"
        case .mil: return "MIL"
        case .nan: return "NAN"
        case .tri: return "TRI"
        case .tda: return "TDA"
        case .gen: return "STAR"
        case .pac: return "PAC"
        case .pmil: return "PACMIL"
        }
    }
}
extension Int {
    var siglasEmpresa: String {
        Empresa(rawValue: self)?.siglas ?? "N/D"
    }
}
struct vistaLoader: View {
    var body: some View {
        VStack (spacing: 15) {
            ProgressView()
                .scaleEffect(1)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
struct ToastView: View {
    let message: String
    var body: some View {
        Text(message)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
//MARK: Creamos el switch para los procesos y la ruta en la que van a navegar
enum ProcesoWf: Int {
    case descuento = 1
    case credito = 2
    case precio = 3
    case desbloqueo = 4
    case geocerca = 5
    case contrato = 6
    case ruta = 9
    case creditoclientes = 10
    case plantilla = 11
    case personal = 12
    case puestos = 13
    case salario = 14
    case reingreso = 15
    case baja = 16
}
enum WfRoute: Hashable {
    case descuento(solicitud: Int)
    case credito(solicitud: Int)
    case precio(solicitud: Int)
    case desbloqueo(solicitud: Int)
    case contrato(solicitud: Int)
    case geocerca(solicitud: Int)
    case ruta(solicitud: Int)
    case creditoclientes(solicitud: Int)
    case plantilla(solicitud: Int)
    case personal(solicitud: Int)
    case puestos(solicitud: Int)
    case salario(solicitud: Int)
    case reingreso(solicitud: Int)
    case baja(solicitud: Int)
    case nosoportado(procesoID: Int, solicitud: Int)
}
