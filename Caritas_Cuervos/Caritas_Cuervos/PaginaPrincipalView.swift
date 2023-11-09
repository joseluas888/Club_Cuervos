//
//  PaginaPrincipalView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct Ficha: Identifiable, Hashable{
    var id: Int
    let f_direccion: String
    let f_nombre: String
    let f_folio: String
    let f_cantidad: String
    let f_referencias: String
    let f_detalles: String
    let f_telCel: String
    let f_telPri: String
    let f_telSec: String
    let f_recibido: Bool
}

var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
var verde:Color = Color(red:0.792156862745098, green:0.8666666666666667, blue:0.8274509803921568)

struct PaginaPrincipalView: View {
    @State var fichas_prueba:[Ficha] = []
    
    var body: some View {
        VStack{
            TabView{
                RecibosPorCobrar(fichas_prueba: $fichas_prueba)
                    .badge(fichas_prueba.count)
                    .tabItem {Label("Por cobrar", systemImage: "dollarsign.circle.fill")}
                RecibosYaCobradosView(fichas_prueba: $fichas_prueba)
                    .tabItem {Label("Cobrados", systemImage: "text.badge.checkmark")}
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PaginaPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PaginaPrincipalView()
    }
}
