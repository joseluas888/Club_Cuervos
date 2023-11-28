//
//  ModelData.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import Foundation

func CallAPIUsuario(_ usuario: String, _ contrasena: String, completion: @escaping (Bool) -> Void) {
    let url = URL(string: "https://equipo18.tc2007b.tec.mx:8082/login")!
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
    if let url = URL(string: "https://equipo18.tc2007b.tec.mx:8082/receipts/\(userID)") {
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

func markReceiptAsPaid(folioRecibo: Int, completion: @escaping (Bool, Error?) -> Void) {
    let urlString = "http://10.14.255.86:8084/paid/\(folioRecibo)"
    
    guard let url = URL(string: urlString) else {
        completion(false, nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(false, error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(false, nil)
            return
        }
        
        if httpResponse.statusCode == 200 {
            completion(true, nil)
        } else {
            completion(false, nil)
        }
    }.resume()
}

func updateCommentForReceipt(folioRecibo: Int, comment: String, completion: @escaping (Bool, Error?) -> Void) {
    let urlString = "http://10.14.255.86:8084/comment/\(folioRecibo)"
    
    guard let url = URL(string: urlString) else {
        completion(false, nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    
    let json: [String: Any] = ["comment": comment]
    guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
        completion(false, nil)
        return
    }
    
    request.httpBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(false, error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(false, nil)
            return
        }
        
        if httpResponse.statusCode == 200 {
            completion(true, nil)
        } else {
            completion(false, nil)
        }
    }.resume()
}
