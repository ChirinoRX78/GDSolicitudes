//
//  LoginView.swift - Vista de inicio de sesión
//  TestWF - GD_Solicitudes
//
//  Created by TI on 09/01/26.
//

import SwiftUI

struct LoginView: View {
    @State private var usuario = ""
    @State private var contrasena = ""
    @State private var usuarioError = 0
    @State private var contrasenaError = 0
    @State private var mostrarContrasena = false
    @State private var mostrarHome = false
    @State private var recordarUsuario = false
    //@State private var cargando = false
    @State private var mostrarError = false
    @State private var mensajeError = ""
    @State private var mensajeBienvenida = ""
    //Animaciones
    @State private var mostrarLoader = false
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    Color("Blue1")
                        .ignoresSafeArea()
                    VStack (spacing: 25) {
                        Image("logoGD")
                            .resizable()
                            .frame(width: 135, height: 135)
                            .padding()
                        ZStack {
                            HStack(spacing: 10) {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 35))
                                    .frame(width: 10)
                                ZStack(alignment: .center) {
                                    if usuario.isEmpty {
                                        Text("Usuario")
                                            .foregroundColor(.white)
                                            .padding(.trailing, 20)
                                            .font(.system(size: 20, weight: .semibold, design: .default))
                                    }
                                    TextField("", text: $usuario)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 20)
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                        .autocapitalization(.none)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .frame(width: 300, height: 50)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: CGFloat(usuarioError))
                        )
                        ZStack {
                            HStack(spacing: 10) {
                                Image(systemName: "shield.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 35))
                                    .frame(width: 10)
                                ZStack(alignment: .center) {
                                    if contrasena.isEmpty {
                                        Text("Contraseña")
                                            .foregroundColor(.white)
                                            .padding()
                                            .font(.system(size: 20, weight: .semibold, design: .default))
                                    }
                                    if mostrarContrasena {
                                        TextField("", text: $contrasena)
                                            .foregroundColor(.white)
                                            .padding()
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 20, weight: .semibold, design: .default))
                                    } else {
                                        SecureField("", text: $contrasena)
                                            .foregroundColor(.white)
                                            .padding()
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 20, weight: .semibold, design: .default))
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                Button(action: {
                                    mostrarContrasena.toggle()
                                }) {
                                    Image(systemName: mostrarContrasena ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 25))
                                }
                                .frame(width: 2)
                            }
                            .padding(.horizontal, 16)
                        }
                        .frame(width: 300, height: 50)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: CGFloat(contrasenaError))
                        )
                        Toggle(isOn: $recordarUsuario) {
                            Text("¿Recordar contraseña?")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold, design: .default))
                        }
                        .toggleStyle(estiloCajita())
                        .onChange(of: recordarUsuario) { oldValue, newValue in
                            let defaults = UserDefaults.standard
                            if newValue {
                                defaults.set(usuario, forKey: Credenciales.usuario)
                                defaults.set(contrasena, forKey: Credenciales.contrasena)
                                defaults.set(true, forKey: Credenciales.recordar)
                            } else {
                                defaults.removeObject(forKey: Credenciales.usuario)
                                defaults.removeObject(forKey: Credenciales.contrasena)
                                defaults.set(false, forKey: Credenciales.recordar)
                            }
                        }
                        //Botón para login:
                        Button(action: {
                            autenticar()
                        }){
                            Text("Acceder")
                                .foregroundColor(.black)
                                .frame(width: 320, height: 55)
                                .background(Color.white)
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .cornerRadius(25)
                        }
                        VStack (spacing: 10){
                            Text("© Grupo D'Amiano 2026")
                                .font(.system(size: 16, design: .default))
                                .foregroundColor(.white)
                            if let version = Bundle.main.appVersion {
                                Text("Versión: \(version)")
                                    .font(.system(size: 16, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, -5)
                        Spacer()
                            .frame(height: 50)
                    }
                }
                .navigationDestination(isPresented: $mostrarHome){
                    HomeView(usuario: usuario)
                }
            }
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
            .zIndex(0)
            if mostrarLoader {
                LoaderLoginView()
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(999)
            }
        }
        .alert(isPresented: $mostrarError) {
            Alert(
                title: Text("Error de acceso"),
                message: Text(mensajeError),
                dismissButton: .default(Text("Aceptar"))
            )
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            let defaults = UserDefaults.standard
            recordarUsuario = defaults.bool(forKey: Credenciales.recordar)
            if recordarUsuario {
                usuario = defaults.string(forKey: Credenciales.usuario) ?? ""
                contrasena = defaults.string(forKey: Credenciales.contrasena) ?? ""
            }
        }
        
    }
    //MARK: Conexión con servicio SOAP para inicio de sesión
    func autenticar(){
        usuarioError = usuario.isEmpty ? 2 : 0
        contrasenaError = contrasena.isEmpty ? 2 : 0
        guard !usuario.isEmpty, !contrasena.isEmpty else {
            mensajeError = "Debe escribir el usuario y contraseña."
            mostrarError = true
            return
        }
        mostrarLoader = true
        ClienteSoap.validaUsuario(usuario: usuario, contrasena: contrasena) {
            esValido in DispatchQueue.main.async {
                mostrarLoader = false
                if esValido {
                    let defaults = UserDefaults.standard
                    if recordarUsuario {
                        defaults.set(usuario, forKey: Credenciales.usuario)
                        defaults.set(contrasena, forKey: Credenciales.contrasena)
                        defaults.set(true, forKey: Credenciales.recordar)
                    }
                    mostrarHome = true
                    mensajeBienvenida = "¡Bienvenid@: \(usuario)!"
                } else {
                    mensajeError = "Usuario o contraseña incorrectos."
                    mostrarError = true
                }
            }
        }
    }
}
struct estiloCajita: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
