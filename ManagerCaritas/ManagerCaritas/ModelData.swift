//
//  ModelData.swift
//  ManagerCaritas
//
//  Created by Alumno on 05/11/23.
//

import Foundation
import SwiftUI

func CallAPIUsuario(_ usuario: String, _ contrasena: String, completion: @escaping (Bool) -> Void) {
    let url = URL(string: "https://equipo18.tc2007b.tec.mx:8443/login_admin")!
    var request = URLRequest(url: url)
    request.setValue("CGDrp4PSEIAdWiMAMRgUIzoaM15luYYp", forHTTPHeaderField: "apikey")
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
    guard let url = URL(string: "https://equipo18.tc2007b.tec.mx:8443/receipts/\(userID)") else {
        print("URL de la API no válida.")
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("CGDrp4PSEIAdWiMAMRgUIzoaM15luYYp", forHTTPHeaderField: "apikey")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
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
}





//LO QUE ME AYUDÓ JOSÉ

//Collector
struct Collector: Decodable, Identifiable {
    var id: Int { idUsuario }
    let idUsuario: Int
    let nombre: String
    let apellidoPaterno: String
    let apellidoMaterno: String
    let zona: String
}

func getCollectors(completion: @escaping ([Collector]?, Error?) -> Void) {
    let urlString = "https://equipo18.tc2007b.tec.mx:8443/collectors"
    
    guard let url = URL(string: urlString) else {
        completion(nil, nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.setValue("CGDrp4PSEIAdWiMAMRgUIzoaM15luYYp", forHTTPHeaderField: "apikey")
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, nil)
            return
        }
        
        do {
            let collectors = try JSONDecoder().decode([Collector].self, from: data)
            completion(collectors, nil)
        } catch {
            completion(nil, error)
        }
    }.resume()
}

//Recibos
struct ReceiptData: Codable {
    let cantidad: Int
    let estadoCobro: String
}

class PieChartData: ObservableObject {
    @Published var dataPie: [(Double, Color)] = []

    func fetchData() {
        guard let url = URL(string: "https://equipo18.tc2007b.tec.mx:8443/paid_unpaid_receipts") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("CGDrp4PSEIAdWiMAMRgUIzoaM15luYYp", forHTTPHeaderField: "apikey")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([ReceiptData].self, from: data)

                    DispatchQueue.main.async { [self] in
                        self.dataPie = decodedData.map { (Double($0.cantidad), self.getColorForEstado($0.estadoCobro)) }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    private func getColorForEstado(_ estado: String) -> Color {
        switch estado {
        case "Cobrados":
            return azul
        case "No cobrados":
            return naranja
        case "Promesas":
            return morado
        default:
            return .gray
        }
    }
}

//Por Zona
struct ZoneReceiptData: Codable, Identifiable {
    let id = UUID()
    let municipio: String
    let cantidad: Int
}

struct ZoneReceiptDataItem: Identifiable {
    let id = UUID()
    let municipio: String
    let cantidad: Int
}

class ZoneChartData: ObservableObject {
    @Published var dataZone: [ZoneReceiptDataItem] = []

    func fetchZoneData() {
        guard let url = URL(string: "https://equipo18.tc2007b.tec.mx:8443/paid_receipts_by_zone") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("CGDrp4PSEIAdWiMAMRgUIzoaM15luYYp", forHTTPHeaderField: "apikey")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([ZoneReceiptData].self, from: data)

                    DispatchQueue.main.async { [self] in
                        self.dataZone = decodedData.map { ZoneReceiptDataItem(municipio: $0.municipio, cantidad: $0.cantidad) }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}


//Ingresos - Dinero
struct IncomeData: Codable {
    let estadoCobro: String
    let sumatoriaMontos: Double
}

struct IncomeDataItem: Identifiable {
    let id = UUID()
    let x: String
    let y: Double
}

class IncomeChartData: ObservableObject {
    @Published var dataLinesXY: [IncomeDataItem] = []

    func fetchIncomeData() {
        guard let url = URL(string: "https://equipo18.tc2007b.tec.mx:8443/income_last_5_days") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("CGDrp4PSEIAdWiMAMRgUIzoaM15luYYp", forHTTPHeaderField: "apikey")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([IncomeData].self, from: data)

                    DispatchQueue.main.async { [self] in
                        self.dataLinesXY = decodedData.map { IncomeDataItem(x: $0.estadoCobro, y: $0.sumatoriaMontos) }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
