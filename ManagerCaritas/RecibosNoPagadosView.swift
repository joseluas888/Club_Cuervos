//
//  RecibosNoPagadosView.swift
//  ManagerCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

struct RecibosNoPagadosView: View {
    @Binding var fichas_prueba:[Ficha]
    
    var body: some View {
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            HeaderParaRecolectoresView(texto: "Recibos no pagados")
            List(){
                ForEach(fichas_prueba) { ficha in
                    if(ficha.f_recibido == false){
                        PlantillaFichaCobradaView(direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.id, cantidad: ficha.f_cantidad, comentario: ficha.f_comentario, telFijo: ficha.f_telPri, telExtra: ficha.f_telSec, telCelular: ficha.f_telCel, recibido: ficha.f_recibido)
                    }
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
        RecibosNoPagadosView(fichas_prueba: $tempVar)
    }
}
