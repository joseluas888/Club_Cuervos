//
//  ModelData.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import Foundation

func CallAPIUsuario() -> Array<Usuario>{
    var usuarioList: Array<Usuario> = []
    guard let url = URL(string: "http://10.14.255.86:8088")
    else{
        print("No pude asignar el URL del API")
        return usuarioList
    }
    let group = DispatchGroup()
    group.enter()
    
    
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            do{
                usuarioList = try jsonDecoder.decode([Usuario].self, from: data!)
                for usuarioItem in usuarioList {
                    print("Id: \(usuarioItem.id) - Usuario: \(usuarioItem.matricula) - Contraseña \(usuarioItem.password)")
                }
            }
            catch{
                print(error)
            }
            group.leave()
        }
    }
    task.resume()
    group.wait()
    print("*******  SALIENDO DE LA FUNCIÓN  *******")
    return usuarioList
}

struct Usuario: Codable, Identifiable{
    var id: Int
    var matricula: Int
    var password: String
}
