//
//  ElementosPrincipalView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct Recibo: Decodable, Identifiable {
    var id: Int { folioRecibo }
    let apellidoMaterno: String
    let apellidoPaterno: String
    let detalles: String
    let calle: String
    let folioRecibo: Int
    let monto: Int
    let municipio: String
    let nombre: String
    let numero: Int
    let referencias: String
    let telefonoCelular: Int
    let telefonoPrincipal: Int
    let telefonoSecundario: Int
}

struct ExpandidosView: View {
    @Binding var push:Bool
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:String = "000"
    @State var cantidad:String = "000.00"
    @State var ref:String = "Una casa normal, de color normal"
    @State var detalles:String = "Entregar cualquier dia, a cualquier hora"
    @State var telFijo:String = "11 1111 1111"
    @State var telExtra:String = "22 2222 2222"
    @State var telCelular:String = "33 3333 3333"
    
    var body: some View {
        ZStack{
            VStack{}
            .padding(.all, 20.0)
            .frame(width: 350.0, height: 450.0)
            .background(blanco)
            .border(blanco)
            .shadow(radius: 5, x: 5, y: 5)
            
            VStack(alignment: .leading){
                Text("\(direccion)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(height: 60.0)
                    .foregroundColor(negro)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("\(nombre)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(negro)
                        Text("Folio: \(folio)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(negro)
                    }
                    Spacer()
                    Text("$\(cantidad)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(naranja)
                }
                
                VStack(alignment: .leading){
                    Text("Referencia: \(ref)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(negro)
                        .frame(height: 50.0)
                    Text("Comentario: \(detalles)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(negro)
                        .frame(height: 50.0)
                    Text("Tel. Fijo: \(telFijo)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(negro)
                        .padding(.top, 10.0)
                    Text("Tel. Extra: \(telExtra)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(negro)
                        .padding(.top, 1.0)
                    Text("Tel. Celular: \(telCelular)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(negro)
                        .padding(.top, 1.0)
                }
                
                HStack{
                    //NavigationLink(destination: DetallesDonanteView()){
                    Button(action: {self.push.toggle()}) {
                        Text("Ocultar")
                    }
                    .frame(width: 145, height: 50.0)
                    .background(verde)
                    .foregroundColor(negro)
                    .cornerRadius(10)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    //NavigationLink(destination: ReciboView(nombre2: nombre, folio2: folio, cantidad2: cantidad)){
                    NavigationLink(destination: ReciboView(nombre2: nombre, folio2: folio, cantidad2: cantidad)){
                    }
                    .frame(width: 140, height: 50.0)
                    .background(azul)
                    .foregroundColor(blanco)
                    .cornerRadius(10)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, 5.0)
            }
            .padding(.all, 20.0)
            .frame(width: 350.0, height: 450.0)
            .background(blanco)
            .border(blanco)
        }
        .padding(.top, 20.0)
    }
}

struct EncogidosView: View {
    @Binding var push:Bool
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:String = "000"
    @State var cantidad:String = "000.00"
    
    var body: some View {
        ZStack{
            VStack{}
            .padding(.all, 20.0)
            .frame(width: 350.0, height: 200.0)
            .background(blanco)
            .border(blanco)
            .shadow(radius: 5, x: 5, y: 5)
            
            VStack(alignment: .leading){
                Text("\(direccion)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(height: 60.0)
                    .foregroundColor(negro)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("\(nombre)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(negro)
                        Text("Folio: \(folio)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(negro)
                    }
                    Spacer()
                    Text("$\(cantidad)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(naranja)
                }
                HStack{
                    //NavigationLink(destination: DetallesDonanteView()){
                    Button(action: {self.push.toggle()}) {
                        Text("Ver información")
                    }
                    .frame(width: 145, height: 50.0)
                    .background(verde)
                    .foregroundColor(negro)
                    .cornerRadius(10)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    ZStack{
                        Text("Recolectar")
                            .frame(width: 140, height: 50.0)
                            .background(azul)
                            .foregroundColor(blanco)
                            .cornerRadius(10)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: ReciboView(nombre2: nombre, folio2: folio, cantidad2: cantidad)){
                        }
                        .frame(width: 140, height: 50.0)
                        .cornerRadius(10)
                        .opacity(0)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 5.0)
            }
            .padding(.all, 20.0)
            .frame(width: 350.0, height: 200.0)
            .background(blanco)
            .border(blanco)
        }
        .padding(.top, 20.0)
    }
}

struct ElementosPrincipalView: View {
    @State private var push = false
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:String = "000"
    @State var cantidad:String = "000.00"
    @State var ref:String = "Una casa normal, de color normal"
    @State var detalles:String = "Entregar cualquier dia, a cualquier hora"
    @State var telFijo:String = "11 1111 1111"
    @State var telExtra:String = "22 2222 2222"
    @State var telCelular:String = "33 3333 3333"
    
    var body: some View {
        ZStack {
            if !push {
                EncogidosView(push: $push, direccion: self.direccion, nombre: self.nombre, folio: self.folio, cantidad: self.cantidad)
            }
            if push {
                ExpandidosView(push: $push, direccion: self.direccion, nombre: self.nombre, folio: self.folio, cantidad: self.cantidad, ref: self.ref, detalles: self.detalles, telFijo: self.telFijo, telExtra: self.telExtra, telCelular: self.telCelular)
            }
        }
    }
}

struct ElementosPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        ElementosPrincipalView()
    }
}
