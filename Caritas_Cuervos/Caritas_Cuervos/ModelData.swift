//
//  ModelData.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import Foundation

func CallAPIUsuario(_ usuario: String, _ contrasena: String, completion: @escaping (Bool) -> Void) {
    let url = URL(string: "http://10.14.255.86:8084/login")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let parameters: [String: Any] = [
        "nombreUsuario": usuario,
        "password": contrasena
    ]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        print(request)
    } catch let error {
        print(error.localizedDescription)
        completion(false)
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            completion(false)
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            
            print(jsonResponse!)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    task.resume()
}

func fetchRecibos(forUserID userID: Int, completion: @escaping ([Recibo]?) -> Void) {
    if let url = URL(string: "http://10.14.255.86:8084/receipts/\(userID)") {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error al hacer la solicitud: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos.")
                completion(nil)
                return
            }
            
            do {
                let recibos = try JSONDecoder().decode([Recibo].self, from: data)
                completion(recibos)
            } catch {
                print("Error al decodificar los datos JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    } else {
        print("URL de la API no válida.")
        completion(nil)
    }
}
