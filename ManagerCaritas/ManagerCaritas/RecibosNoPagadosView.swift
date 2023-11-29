//
//  RecibosNoPagadosView.swift
//  ManagerCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

struct RecibosNoPagadosView: View {
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_pagadas:[Ficha]
    @Binding var fichas_noPagadas:[Ficha]
    
    var body: some View {
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            HeaderParaRecolectoresView(texto: "Recibos no pagados")
            List(){
                ForEach(fichas_noPagadas) { ficha in
                    PlantillaFichaCobradaView(direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.id, cantidad: ficha.f_cantidad, comentario: ficha.f_comentario, telFijo: ficha.f_telPri, telExtra: ficha.f_telSec, telCelular: ficha.f_telCel, recibido: ficha.f_recibido)
                }
                .listRowBackground(blanco)
            }
            .background(blanco)
            .listStyle(.plain)
            Spacer()
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct RecibosNoPagadosView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        @State var tempVar2:[Ficha] = []
        @State var tempVar3:[Ficha] = []
        RecibosNoPagadosView(fichas_porCobrar: $tempVar, fichas_pagadas: $tempVar2, fichas_noPagadas: $tempVar3)
    }
}
