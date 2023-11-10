//
//  ElementosYaCobradosView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct ExpandidosCobradosView: View {
    @Binding var push:Bool
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:Int = 0
    @State var cantidad:String = "000.00"
    //@State var ref:String = "Una casa normal, de color normal"
    //@State var detalles:String = "Entregar cualquier dia, a cualquier hora"
    @State var comentario:String = "Ninguno"
    @State var telFijo:String = "11 1111 1111"
    @State var telExtra:String = "22 2222 2222"
    @State var telCelular:String = "33 3333 3333"
    @State var recibido:Bool = false
    
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
                        Text(verbatim: "Folio: \(folio)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(negro)
                    }
                    Spacer()
                    Text("$\(cantidad)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(negro)
                }
                
                VStack(alignment: .leading){
                    Text("Comentario del recolector:")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(negro)
                        .padding(.top, 30.0)
                        .frame(height: 20.0)
                    Text("\(comentario)")
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
                    if(recibido == true){
                        Image(systemName: "checkmark")
                            .foregroundColor(azul)
                        Text("Recibido")
                            .frame(width: 100, height: 50.0)
                            .foregroundColor(azul)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    else{
                        Image(systemName: "xmark")
                            .foregroundColor(naranja)
                        Text("No Recibido")
                            .frame(width: 100, height: 50.0)
                            .foregroundColor(naranja)
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 40.0)
            }
            .padding(.all, 20.0)
            .frame(width: 350.0, height: 450.0)
            .background(blanco)
            .border(blanco)
        }
        .padding(.top, 20)
    }
}

struct EncogidosCobradosView: View {
    @Binding var push:Bool
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:Int = 0
    @State var cantidad:String = "000.00"
    @State var recibido:Bool = false
    
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
                        Text(verbatim: "Folio: \(folio)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(negro)
                    }
                    Spacer()
                    Text("$\(cantidad)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(negro)
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
                    if(recibido == true){
                        Image(systemName: "checkmark")
                            .foregroundColor(azul)
                        Text("Recibido")
                            .frame(width: 100, height: 50.0)
                            .foregroundColor(azul)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    else{
                        Image(systemName: "xmark")
                            .foregroundColor(naranja)
                        Text("No Recibido")
                            .frame(width: 100, height: 50.0)
                            .foregroundColor(naranja)
                            .font(.subheadline)
                            .fontWeight(.bold)
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

struct ElementosYaCobradosView: View {
    @State private var push = false
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:Int = 0
    @State var cantidad:String = "000.00"
    //@State var ref:String = "Una casa normal, de color normal"
    //@State var detalles:String = "Entregar cualquier dia, a cualquier hora"
    @State var comentario:String = "Ninguno"
    @State var telFijo:String = "11 1111 1111"
    @State var telExtra:String = "22 2222 2222"
    @State var telCelular:String = "33 3333 3333"
    @State var recibido:Bool = false
    
    var body: some View {
        ZStack {
            if !push {
                EncogidosCobradosView(push: $push, direccion: self.direccion, nombre: self.nombre, folio: self.folio, cantidad: self.cantidad, recibido: self.recibido)
            }
            if push {
                ExpandidosCobradosView(push: $push, direccion: self.direccion, nombre: self.nombre, folio: self.folio, cantidad: self.cantidad, comentario: self.comentario, telFijo: self.telFijo, telExtra: self.telExtra, telCelular: self.telCelular, recibido: self.recibido)
            }
        }
    }
}

struct ElementosYaCobradosView_Previews: PreviewProvider {
    static var previews: some View {
        ElementosYaCobradosView()
    }
}
