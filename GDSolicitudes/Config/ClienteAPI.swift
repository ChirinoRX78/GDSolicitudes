//
//  ClienteAPI.swift
//  TestWF
//
//  Created by TI on 16/01/26.
//
import Foundation

class ClienteAPI {
    static func obtenerInfo(
        usuario: String,
        completion: @escaping (Result<RespuestaAPI, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosUsuario"
        )
        components?.queryItems = [
            URLQueryItem(name: "user", value: usuario)
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error de red:", error)
                completion(.failure(error))
                return
            }
            if let http = response as? HTTPURLResponse {
                print("Estatus:", http.statusCode)
            }
            guard let data = data else {
                print("❌ No hay información")
                completion(.failure(NSError()))
                return
            }
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
            //print("JSON:")
            //print(raw)
            do {
                let response = try JSONDecoder().decode(RespuestaAPI.self, from: data)
                completion(.success(response))
            } catch {
                print("❌ Error decodificando JSON:")
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    //MARK: Proceso 1
    static func obtenerDescuento(
        solicitud: Int,
        completion: @escaping (Result<RespuestaDescuento, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosCredito"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
            //print("JSON Desbloqueo RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaDescuento.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando descuento:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 2
    static func obtenerCredito(
        solicitud: Int,
        completion: @escaping (Result<RespuestaCredito, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosCredito"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
            //print("JSON Desbloqueo RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaCredito.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando crédito:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 3
    static func obtenerPrecio(
        solicitud: Int,
        completion: @escaping (Result<RespuestaPrecio, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosPrecio"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Desbloqueo RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaPrecio.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando precio:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 4
    static func obtenerDesbloqueo(
        solicitud: Int,
        completion: @escaping (Result<RespuestaDesbloqueo, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosDesbloqueo"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Desbloqueo RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaDesbloqueo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando desbloqueo:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 5
    static func obtenerGeocerca(
        solicitud: Int,
        completion: @escaping (Result<RespuestaGeocerca, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosGeocerca"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Desbloqueo RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaGeocerca.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando desbloqueo:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 6
    static func obtenerContrato(
        solicitud: Int,
        completion: @escaping (Result<RespuestaContrato, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosContrato"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaContrato.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando contrato:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 9
    static func obtenerRuta(
        solicitud: Int,
        completion: @escaping (Result<RespuestaRuta, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosRuta"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaRuta.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando ruta:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 10
    static func obtenerCreditoClientes(
        solicitud: Int,
        completion: @escaping (Result<RespuestaCreditoClientes, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosCreditoClientes"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaCreditoClientes.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando crédito a clientes:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 11
    static func obtenerPlantilla(
        solicitud: Int,
        completion: @escaping (Result<RespuestaPlantilla, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosPlantilla"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaPlantilla.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando plantilla:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 12
    static func obtenerPersonal(
        solicitud: Int,
        completion: @escaping (Result<RespuestaPersonal, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosPersonal"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaPersonal.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando personal:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 13
    static func obtenerPuesto(
        solicitud: Int,
        completion: @escaping (Result<RespuestaPuesto, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosPuesto"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaPuesto.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando puesto:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 14
    static func obtenerSalario(
        solicitud: Int,
        completion: @escaping (Result<RespuestaSalario, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosSalario"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaSalario.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando salario:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 15
    static func obtenerReingreso(
        solicitud: Int,
        completion: @escaping (Result<RespuestaReingreso, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosReingreso"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Contrato RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaReingreso.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando reingreso:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Proceso 16
    static func obtenerBaja(
        solicitud: Int,
        completion: @escaping (Result<RespuestaBaja, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosBaja"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaBaja.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando baja:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Archivos solicitudes
    static func obtenerArchivo(
        solicitud: Int,
        completion: @escaping (Result<RespuestaArchivo, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosArchivo"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(RespuestaArchivo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando archivo:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Solicitudes autorizadas
    static func obtenerSolicitudesAutorizadas(
        empresa: Int,
        proceso: Int,
        cliente: Int,
        completion: @escaping (Result<RespuestaSolAutorizadas, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosSolicitudesAutorizadas"
        )
        components?.queryItems = [
            URLQueryItem(name: "empresa", value: String(empresa)),
            URLQueryItem(name: "proceso", value: String(proceso)),
            URLQueryItem(name: "cliente", value: String(cliente))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaSolAutorizadas.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando solicitudes autorizadas:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Facturas vencidas
    static func obtenerFacturasVencidas(
        empresa: Int,
        solicitud: Int,
        cliente: Int,
        completion: @escaping (Result<RespuestaFacturas, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosFacturasVencidas"
        )
        components?.queryItems = [
            URLQueryItem(name: "empresa", value: String(empresa)),
            URLQueryItem(name: "solicitud", value: String(solicitud)),
            URLQueryItem(name: "cliente", value: String(cliente))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaFacturas.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando facturas vencidas:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Contratos de clientes
    static func obtenerContratoCliente(
        empresa: Int,
        cliente: Int,
        completion: @escaping (Result<RespuestaContratos, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosContratoCliente"
        )
        components?.queryItems = [
            URLQueryItem(name: "empresa", value: String(empresa)),
            URLQueryItem(name: "cliente", value: String(cliente))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaContratos.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando contratos de clientes:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Contratos de clientes
    static func obtenerDescuentoCliente(
        empresa: Int,
        cliente: Int,
        completion: @escaping (Result<RespuestaDescuentos, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosDescuentoCliente"
        )
        components?.queryItems = [
            URLQueryItem(name: "empresa", value: String(empresa)),
            URLQueryItem(name: "cliente", value: String(cliente))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaDescuentos.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando descuentos de clientes:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Consumos de ruta
    static func obtenerRutaConsumo(
        solicitud: Int,
        completion: @escaping (Result<RespuestaArticulo, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosRutaConsumo"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud)),
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaArticulo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando descuentos de clientes:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Roles de personal
    static func obtenerPersonalRol(
        solicitud: Int,
        completion: @escaping (Result<RespuestaRoles, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosPersonalRol"
        )
        components?.queryItems = [
            URLQueryItem(name: "solicitud", value: String(solicitud)),
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaRoles.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando artículo de rutas:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    //MARK: Contratos equipo
    static func obtenerContratoEquipo(
        empresa: Int,
        solicitud: Int,
        completion: @escaping (Result<RespuestaEquipos, Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://www.ti.intranetgd.com.mx/getInfo/datosContratoEquipo"
        )
        components?.queryItems = [
            URLQueryItem(name: "empresa", value: String(empresa)),
            URLQueryItem(name: "solicitud", value: String(solicitud))
        ]
        guard let url = components?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "sinData", code: 0)))
                return
            }
            // DEBUG
//            let raw = String(data: data, encoding: .utf8) ?? "SIN TEXTO"
//            print("JSON Bajas RAW:\n\(raw)")
            do {
                let decoded = try JSONDecoder().decode(RespuestaEquipos.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("❌ Error decodificando contratos de equipos:", error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
