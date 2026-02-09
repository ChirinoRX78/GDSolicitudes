//
//  HomeView.swift
//  TestWF
//
//  Created by TI on 09/01/26.
//
import SwiftUI
import Foundation

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var tiempo = "15 minutos"
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
                    Text("Configuración")
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
                        Image(systemName: "clock.arrow.trianglehead.2.counterclockwise.rotate.90")
                            .foregroundColor(Color("Blue1"))
                            .font(.system(size: 25, weight: .bold))
                            .padding(.trailing, 300)
                        Text("Tiempo de espera:")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.black)
                            .padding(.leading, 40)
                        Menu {
                            Button("15 minutos", action: {tiempo = "15 minutos"})
                            Button("20 minutos", action: {tiempo = "20 minutos"})
                            Button("25 minutos", action: {tiempo = "25 minutos"})
                            Button("30 minutos", action: {tiempo = "30 minutos"})
                        } label: {
                            Text(tiempo)
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(Color("Blue1"))
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color("Blue1"))
                                .font(.system(size: 16, weight: .bold))
                        }
                        .padding(.leading, 200)
                    }
                    .padding(.top, 10)
                    ZStack(alignment: .leading) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(Color("Blue1"))
                            .font(.system(size: 25, weight: .bold))
                            .padding(.trailing, 300)
                        Text("Versión de la aplicación:")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.black)
                            .padding(.leading, 40)
                        if let version = Bundle.main.appVersion {
                            Text("\(version)")
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(Color("Blue1"))
                                .padding(.leading, 230)
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
            .onAppear {
                // Cargar valor guardado
                let defaults = UserDefaults.standard
                    tiempo = defaults.string(forKey: PreferencesView.tiempoEspera) ?? "15 minutos"
            }
        }
    }
    private func seleccionarTiempo(_ valor: String) {
        tiempo = valor
        UserDefaults.standard.set(valor, forKey: PreferencesView.tiempoEspera)
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
