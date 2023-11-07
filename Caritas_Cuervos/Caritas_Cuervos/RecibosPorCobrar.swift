//
//  RecibosPorCobrar.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct RecibosPorCobrar: View {
    @State var fichas_prueba:[Ficha] = []
    
    var body: some View {
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            HeaderPrincipalView()
            List(){
                ForEach(fichas_prueba) { ficha in
                    ElementosPrincipalView(direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.f_folio, cantidad: ficha.f_cantidad)
                }
                .onMove(perform: move)
                .listRowBackground(blanco)
            }
            .background(blanco)
            .listStyle(.plain)
            Spacer()
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        fichas_prueba.move(fromOffsets: source, toOffset: destination)
    }
}

struct RecibosPorCobrar_Previews: PreviewProvider {
    static var previews: some View {
        RecibosPorCobrar()
    }
}
