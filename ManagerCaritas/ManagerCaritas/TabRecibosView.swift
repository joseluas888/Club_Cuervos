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
    @State var id_recolector:Int = 1
    @State var fichas_porCobrar:[Ficha] = []
    @State var fichas_pagadas:[Ficha] = []
    @State var fichas_noPagadas:[Ficha] = []
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
                RecibosPorCobrarView(fichas_porCobrar: self.$fichas_porCobrar, fichas_pagadas: self.$fichas_pagadas, fichas_noPagadas: self.$fichas_noPagadas, id_recolector: self.$id_recolector)
                    .tabItem {Label("Por cobrar", systemImage: "dollarsign.circle.fill")}
                RecibosPagadosView(fichas_porCobrar: self.$fichas_porCobrar, fichas_pagadas: self.$fichas_pagadas, fichas_noPagadas: self.$fichas_noPagadas)
                    .tabItem {Label("Pagados", systemImage: "checkmark.circle.fill")}
                RecibosNoPagadosView(fichas_porCobrar: self.$fichas_porCobrar, fichas_pagadas: self.$fichas_pagadas, fichas_noPagadas: self.$fichas_noPagadas)
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
