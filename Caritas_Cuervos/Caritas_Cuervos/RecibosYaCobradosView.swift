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
                    ElementosYaCobradosView(direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.f_folio, cantidad: ficha.f_cantidad, recibido: ficha.f_recibido)
                }
                .listRowBackground(blanco)
            }
            .background(blanco)
            .listStyle(.plain)
            Spacer()
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
        /*.onAppear{
            fetchRecibos(forUserID: 1) { recibos in
                if let recibos = recibos {
                    fichas_prueba = recibos.map { recibo in
                        return Ficha(f_direccion: "\(recibo.calle), \(recibo.municipio) \(recibo.numero), \(recibo.referencias)", f_nombre: "\(recibo.nombre) \(recibo.apellidoPaterno) \(recibo.apellidoMaterno)", f_folio: "\(recibo.folioRecibo)", f_cantidad: "\(recibo.monto)", f_referencias: recibo.referencias, f_detalles: recibo.detalles, f_telCel: "\(recibo.telefonoCelular)", f_telPri: "\(recibo.telefonoPrincipal)", f_telSec: "\(recibo.telefonoSecundario)", f_recibido: false)
                    }
                }
            }
        }*/
    }
}

struct RecibosYaCobradosView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        RecibosYaCobradosView(fichas_prueba: $tempVar)
    }
}
