//
//  TabRecibosView.swift
//  ManagerCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

//Estructura de ficha que usan las diversas vistas de la app
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
    var f_recibido: Bool
    var f_comentario: String
}

struct TabRecibosView: View {
    //Fichas dummy para pruebas
    @State var fichas_prueba:[Ficha] = [
        Ficha(id: 1, f_direccion: "Direccion Algo ###",
              f_nombre: "Nombre Apellido", f_folio: "###",
              f_cantidad: "###", f_referencias: "Ninguna",
              f_detalles: "Ninguna", f_telCel: "00-0000-0000",
              f_telPri: "00-0000-0000", f_telSec: "00-0000-0000",
              f_recibido: false, f_comentario: "Ninguno"),
        Ficha(id: 2, f_direccion: "Direccion Algo ###", f_nombre: "Nombre Apellido", f_folio: "###", f_cantidad: "###", f_referencias: "Ninguna", f_detalles: "Ninguna", f_telCel: "00-0000-0000", f_telPri: "00-0000-0000", f_telSec: "00-0000-0000", f_recibido: true, f_comentario: "Ninguno"),
        Ficha(id: 3, f_direccion: "Direccion Algo ###", f_nombre: "Nombre Apellido", f_folio: "###", f_cantidad: "###", f_referencias: "Ninguna", f_detalles: "Ninguna", f_telCel: "00-0000-0000", f_telPri: "00-0000-0000", f_telSec: "00-0000-0000", f_recibido: false, f_comentario: "Ninguno"),
        Ficha(id: 4, f_direccion: "Direccion Algo ###", f_nombre: "Nombre Apellido", f_folio: "###", f_cantidad: "###", f_referencias: "Ninguna", f_detalles: "Ninguna", f_telCel: "00-0000-0000", f_telPri: "00-0000-0000", f_telSec: "00-0000-0000", f_recibido: true, f_comentario: "Ninguno"),
        Ficha(id: 5, f_direccion: "Direccion Algo ###", f_nombre: "Nombre Apellido", f_folio: "###", f_cantidad: "###", f_referencias: "Ninguna", f_detalles: "Ninguna", f_telCel: "00-0000-0000", f_telPri: "00-0000-0000", f_telSec: "00-0000-0000", f_recibido: false, f_comentario: "Ninguno")
    ]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
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
            TabView{
                RecibosPorCobrarView(fichas_prueba: self.$fichas_prueba)
                    .tabItem {Label("Por cobrar", systemImage: "dollarsign.circle.fill")}
                RecibosPagadosView(fichas_prueba: self.$fichas_prueba)
                    .tabItem {Label("Pagados", systemImage: "checkmark.circle.fill")}
                RecibosNoPagadosView(fichas_prueba: self.$fichas_prueba)
                    .tabItem {Label("No pagados", systemImage: "xmark.circle.fill")}
            }
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct TabRecibosView_Previews: PreviewProvider {
    static var previews: some View {
        TabRecibosView()
    }
}
