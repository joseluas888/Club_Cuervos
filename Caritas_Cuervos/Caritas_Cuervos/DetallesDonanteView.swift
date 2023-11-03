//
//  DetallesDonanteView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct DetallesDonanteView: View {
    @State var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
    @State var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
    @State var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
    @State private var direccion = "Villas de Suiza 245, Roble Nuevo, 66055 Cd Gral Escobedo N.L, Mexico"
    @State private var referencia = "Casa verde de dos pisos"
    @State private var comentario = "Recolectar el 23 de cada mes a las 10:00 am"
    @State private var telefonoFijo = "81 1929 9755"
    @State private var telefonoExtra = "81 1105 8953"
    @State private var telefonoCelular = "81 1005 8953"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Button{
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(negro)
                    .padding(.leading, 20.0)
                    .frame(width: 60.0)
            }
            
            HStack {
                Text("Detalles del donante")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(negro)
            }
            .padding(.top, 16)
            
            Text("Dirección:")
                .font(.headline)
                .bold()
                .padding(.top, 16)
                .padding(.leading, 16)
                .font(.headline)
                .foregroundColor(negro)
            
            HStack {
                Text(direccion)
                    .font(.body)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .foregroundColor(negro)
                Image(systemName: "door.left.hand.closed")
                    .font(.system(size: 40))
                    .foregroundColor(azul)
                    .padding(.leading, 16)
            }
            
            Text("Referencias:")
                .font(.headline)
                .bold()
                .padding(.top, 16)
                .padding(.leading, 16)
                .font(.headline)
                .foregroundColor(negro)
            
            HStack {
                Text(referencia)
                    .font(.body)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .foregroundColor(negro)
                Image(systemName: "house.fill")
                    .font(.system(size: 40))
                    .foregroundColor(azul)
                    .padding(.leading, 16)
            }
            
            Text("Comentarios:")
                .font(.headline)
                .bold()
                .padding(.top, 16)
                .padding(.leading, 16)
                .foregroundColor(negro)
            
            HStack {
                Text(comentario)
                    .font(.body)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .foregroundColor(negro)
                Image(systemName: "message")
                    .font(.system(size: 40))
                    .foregroundColor(azul)
                    .padding(.leading, 16)
            }
            
            VStack {
                HStack {
                    Text("Teléfono fijo")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .bold()
                        .foregroundColor(negro)
                    Text(telefonoFijo)
                        .font(.body)
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .foregroundColor(negro)
                    Spacer()
                    Image(systemName: "phone")
                        .font(.system(size: 40))
                        .foregroundColor(azul)
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    Text("Telefono extra:")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .bold()
                        .foregroundColor(negro)
                    Text(telefonoExtra)
                        .font(.body)
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .foregroundColor(negro)
                    Spacer()
                    Image(systemName: "phone")
                        .font(.system(size: 40))
                        .foregroundColor(azul)
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    Text("Telefono celular:")
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .bold()
                        .foregroundColor(negro)
                    Text(telefonoCelular)
                        .font(.body)
                        .font(.headline)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .foregroundColor(negro)
                    Spacer()
                    Image(systemName: "iphone.gen2")
                        .font(.system(size: 40))
                        .foregroundColor(azul)
                        .padding(.leading, 16)
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(.top, 30)
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct DetallesDonanteView_Previews: PreviewProvider {
    static var previews: some View {
        DetallesDonanteView()
    }
}
