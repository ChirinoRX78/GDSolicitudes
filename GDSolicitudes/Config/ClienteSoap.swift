//
//  ClienteSoap.swift
//  TestWF
//
//  Created by TI on 14/01/26.
//

import Foundation

class ClienteSoap {
    private static let namespace = "http://zafiroerp.com/"
    private static let url_string = "https://validausuario.zafirosoft.com/ZERPValidaUsuario.asmx"
    private static let method_name = "ValidaUsuario"
    private static let soap_action = "http://zafiroerp.com/ValidaUsuario"
    static func validaUsuario(
        usuario: String,
        contrasena: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard let url = URL(string: url_string) else {
            completion(false)
            return
        }
        let soapMessage = """
                <?xml version="1.0" encoding="utf-8"?>
                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                               xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                    <soap:Body>
                        <\(method_name) xmlns="\(namespace)">
                            <Usuario>\(usuario)</Usuario>
                            <Contrasena>\(contrasena)</Contrasena>
                        </\(method_name)>
                    </soap:Body>
                </soap:Envelope>
                """
        var solicitud = URLRequest(url: url)
        solicitud.httpMethod = "POST"
        solicitud.httpBody = soapMessage.data(using: .utf8)
        solicitud.setValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        solicitud.setValue(soap_action, forHTTPHeaderField: "SOAPAction")
        solicitud.setValue("\(soapMessage.count)", forHTTPHeaderField: "Content-Length")
        solicitud.timeoutInterval = 60
        let task = URLSession.shared.dataTask(with: solicitud) {data, response, error in
            if let error = error {
                print("Error SOAP: ", error)
                completion(false)
                return
            }
            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                completion(false)
                return
            }
            print("Respuesta del servidor: ")
            print(responseString)
            let isValid = responseString.lowercased().contains("true")
            completion(isValid)
        }
        task.resume()
    }
}
