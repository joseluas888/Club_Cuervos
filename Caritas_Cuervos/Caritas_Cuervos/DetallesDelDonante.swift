//
//  DetallesDelDonante.swift
//  PantallaDetallesdelDonante
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct DetallesDelDonante: View {
    @State private var direccion = "Villas de Suiza 245, Roble Nuevo, 66055 Cd Gral Escobedo N.L, Mexico"
    @State private var referencia = "Casa verde de dos pisos"
    @State private var comentario = "Recolectar el 23 de cada mes a las 10:00 am"
    @State private var telefonoFijo = "81 1929 9755"
    @State private var telefonoExtra = "81 1105 8953"
    @State private var telefonoCelular = "81 1005 8953"
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
            
            Button(action: {
            
            }) {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()
            
            HStack {
                Text("Detalles del donante")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, 16)
            
            Text("Dirección:")
                .font(.headline)
                .bold()
                .padding(.top, 16)
                .padding(.leading, 16)
                .font(.headline)
            
            HStack {
                Text(direccion)
                    .font(.body)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                Image(systemName: "door.left.hand.closed")
                    .font(.system(size: 40))
                    .foregroundColor(.teal)
                    .padding(.leading, 16)
            }
            

            
            Text("Referencias:")
                .font(.headline)
                .bold()
                .padding(.top, 16)
                .padding(.leading, 16)
                .font(.headline)
            
            HStack {
                Text(referencia)
                    .font(.body)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                Image(systemName: "house.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.teal)
                    .padding(.leading, 16)
            }
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity * 0.5)
                    .padding()            }
        }.padding(.top, 0)
        
        VStack(alignment: .leading) {
            Text("Comentarios:")
                .font(.headline)
                .bold()
                .padding(.top, 16)
                .padding(.leading, 16)
            
            HStack {
                Text(comentario)
                    .font(.body)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                Image(systemName: "message")
                    .font(.system(size: 40))
                    .foregroundColor(.teal)
                    .padding(.leading, 16)
            }
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity )
                    .padding()
            }
            
            VStack {
                HStack {
                    Text("Teléfono fijo")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .bold()
                    Text(telefonoFijo)
                        .font(.body)
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                    Spacer()
                    Image(systemName: "phone")
                        .font(.system(size: 40))
                        .foregroundColor(.teal)
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    Text("Telefono extra:")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .bold()
                    Text(telefonoExtra)
                        .font(.body)
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                    Spacer()
                    Image(systemName: "phone")
                        .font(.system(size: 40))
                        .foregroundColor(.teal)
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    Text("Telefono celular:")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .bold()
                    Text(telefonoCelular)
                        .font(.body)
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                    Spacer()
                    Image(systemName: "iphone.gen2")
                        .font(.system(size: 40))
                        .foregroundColor(.teal)
                        .padding(.leading, 16)
                    Spacer()
                }
            }
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    
            }
        }.padding(.top, 0)
    }
}
