//
//  PaginaPrincipalView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct Ficha: Identifiable, Hashable{
    let f_direccion: String
    let f_nombre: String
    let f_folio: String
    let f_cantidad: String
    let f_recibido: Bool
    let id = UUID()
}

var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
var verde:Color = Color(red:0.792156862745098, green:0.8666666666666667, blue:0.8274509803921568)

struct PaginaPrincipalView: View {
    @State var fichas_prueba = [
        Ficha(f_direccion: "Calle de prueba #001, Colonia TEC 12345",f_nombre: "Ángel García", f_folio: "2207", f_cantidad: "100.00", f_recibido: true),
        Ficha(f_direccion: "Calle de prueba #002, Colonia TEC 12345", f_nombre: "Alejandro Fuentes", f_folio: "2609", f_cantidad: "200.00", f_recibido: false),
        Ficha(f_direccion: "Calle de prueba #003, Colonia TEC 12345", f_nombre: "José Plascencia", f_folio: "2908", f_cantidad: "300.00", f_recibido: true),
        Ficha(f_direccion: "Calle de prueba #004, Colonia TEC 12345", f_nombre: "Nallely Serna", f_folio: "2307", f_cantidad: "400.00", f_recibido: true),
        Ficha(f_direccion: "Calle de prueba #005, Colonia TEC 12345", f_nombre: "José Salazar", f_folio: "0912", f_cantidad: "500.00", f_recibido: false)
    ]
    
    var body: some View {
        TabView{
            RecibosPorCobrar(fichas_prueba: self.fichas_prueba)
                .badge(fichas_prueba.count)
                .tabItem {Label("Por cobrar", systemImage: "dollarsign.circle.fill")}
            RecibosYaCobradosView(fichas_prueba: self.fichas_prueba)
                .tabItem {Label("Cobrados", systemImage: "text.badge.checkmark")}
        }
    }
}

struct PaginaPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PaginaPrincipalView()
    }
}
