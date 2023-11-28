//
//  ElementosPrincipalView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct Recibo: Decodable, Identifiable {
    var id: Int { folioRecibo }
    let cobrado: Int
    let comentarios: String?
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
    @ObservedObject var modalState:ModalState
    
    @Binding var push:Bool
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_cobradas:[Ficha]
    @Binding var g_nombre:String
    @Binding var g_folio:Int
    @Binding var g_cantidad:String
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:Int = 0
    @State var cantidad:String = "000"
    @State var ref:String = "Una casa normal, de color normal"
    @State var detalles:String = "Entregar cualquier dia, a cualquier hora"
    @State var telFijo:String = "11 1111 1111"
    @State var telExtra:String = "22 2222 2222"
    @State var telCelular:String = "33 3333 3333"
    //@Binding var comentario:String
    
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
                    Text("$\(cantidad).00")
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
                    Text("Detalles: \(detalles)")
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
                    ZStack{
                        /*Text("Recolectar")
                            .frame(width: 140, height: 50.0)
                            .background(azul)
                            .foregroundColor(blanco)
                            .cornerRadius(10)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: ReciboView(modalState: self.modalState, fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, nombre: nombre, folio: folio, cantidad: cantidad)){}*/
                        Button("Recolectar"){
                            self.g_nombre = self.nombre
                            self.g_folio = self.folio
                            self.g_cantidad = self.cantidad
                            self.modalState.isModal1Present = true
                        }
                        .frame(width: 140, height: 50.0)
                        .background(azul)
                        .foregroundColor(blanco)
                        .cornerRadius(10)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $modalState.isModal1Present){
                            ReciboView(modalState: self.modalState, fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, nombre: self.g_nombre, folio: self.g_folio, cantidad: self.g_cantidad)
                        }
                    }
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
    @ObservedObject var modalState:ModalState
    
    @Binding var push:Bool
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_cobradas:[Ficha]
    @Binding var g_nombre:String
    @Binding var g_folio:Int
    @Binding var g_cantidad:String
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:Int = 0
    @State var cantidad:String = "000"
    //@Binding var comentario:String
    
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
                    Text("$\(cantidad).00")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(naranja)
                }
                HStack{
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
                        /*Text("Recolectar")
                            .frame(width: 140, height: 50.0)
                            .background(azul)
                            .foregroundColor(blanco)
                            .cornerRadius(10)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .buttonStyle(PlainButtonStyle())*/
                        //NavigationLink(destination: ReciboView(fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, nombre: nombre, folio: folio, cantidad: cantidad)){}
                        Button("Recolectar"){
                            self.g_nombre = self.nombre
                            self.g_folio = self.folio
                            self.g_cantidad = self.cantidad
                            self.modalState.isModal1Present = true
                        }
                        .frame(width: 140, height: 50.0)
                        .background(azul)
                        .foregroundColor(blanco)
                        .cornerRadius(10)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $modalState.isModal1Present){
                            ReciboView(modalState: self.modalState, fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, nombre: self.g_nombre, folio: self.g_folio, cantidad: self.g_cantidad)
                        }
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
    @ObservedObject var modalState:ModalState
    
    @State private var push = false
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_cobradas:[Ficha]
    @Binding var g_nombre:String
    @Binding var g_folio:Int
    @Binding var g_cantidad:String
    
    @State var direccion:String = "Calle #Casa, Colonia #CP"
    @State var nombre:String = "Nombre Apellido"
    @State var folio:Int = 0
    @State var cantidad:String = "000"
    @State var ref:String = "Una casa normal, de color normal"
    @State var detalles:String = "Entregar cualquier dia, a cualquier hora"
    @State var telFijo:String = "11 1111 1111"
    @State var telExtra:String = "22 2222 2222"
    @State var telCelular:String = "33 3333 3333"
    //@Binding var comentario:String
    
    var body: some View {
        ZStack {
            if !push {
                EncogidosView(modalState: self.modalState, push: $push, fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, g_nombre: self.$g_nombre, g_folio: self.$g_folio, g_cantidad: self.$g_cantidad, direccion: self.direccion, nombre: self.nombre, folio: self.folio, cantidad: self.cantidad)
            }
            if push {
                ExpandidosView(modalState: self.modalState, push: $push, fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, g_nombre: self.$g_nombre, g_folio: self.$g_folio, g_cantidad: self.$g_cantidad, direccion: self.direccion, nombre: self.nombre, folio: self.folio, cantidad: self.cantidad, ref: self.ref, detalles: self.detalles, telFijo: self.telFijo, telExtra: self.telExtra, telCelular: self.telCelular)
            }
        }
    }
}

struct ElementosPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar0 = ModalState()
        @State var tempVar:[Ficha] = []
        @State var tempVar2:[Ficha] = []
        @State var tempVar3:String = ""
        @State var tempVar4:Int = 0
        @State var tempVar5:String = ""
        ElementosPrincipalView(modalState: tempVar0, fichas_porCobrar: $tempVar, fichas_cobradas: $tempVar2, g_nombre: $tempVar3, g_folio: $tempVar4, g_cantidad: $tempVar5)
    }
}
