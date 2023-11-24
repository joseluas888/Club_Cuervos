//
//  RecibosYaCobradosView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct RecibosYaCobradosView: View {
    @Binding var fichas_prueba:[Ficha]
    
    var body: some View {
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            HeaderPrincipalView(texto: "Recibos ya cobrados")
            List(){
                ForEach(fichas_prueba) { ficha in
                    ElementosYaCobradosView(direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.id, cantidad: ficha.f_cantidad, comentario: ficha.f_comentario, telFijo: ficha.f_telPri, telExtra: ficha.f_telSec, telCelular: ficha.f_telCel, recibido: ficha.f_recibido)
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

struct RecibosYaCobradosView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        RecibosYaCobradosView(fichas_prueba: $tempVar)
    }
}
