//
//  RecibosPorCobrarView.swift
//  ManagerCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

struct RecibosPorCobrarView: View {
    @Binding var fichas_prueba:[Ficha]
    
    var body: some View {
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            HeaderParaRecolectoresView(texto: "Recibos por cobrar")
            List(){
                ForEach(fichas_prueba) { ficha in
                    PlantillaFichaPorCobrarView(direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.id, cantidad: ficha.f_cantidad, ref: ficha.f_referencias, detalles: ficha.f_detalles, telFijo: ficha.f_telPri, telExtra: ficha.f_telSec, telCelular: ficha.f_telCel)
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
            if(fichas_prueba.count == 0){
                fetchRecibos(forUserID: 1) { recibos in
                    if let recibos = recibos {
                        fichas_prueba = recibos.map { recibo in
                            return Ficha(id: recibo.folioRecibo, f_direccion: "\(recibo.calle), \(recibo.municipio) \(recibo.numero), \(recibo.referencias)",f_nombre: "\(recibo.nombre) \(recibo.apellidoPaterno) \(recibo.apellidoMaterno)", f_folio: "\(recibo.folioRecibo)", f_cantidad: "\(recibo.monto)", f_referencias: recibo.referencias, f_detalles: recibo.detalles, f_telCel: "\(recibo.telefonoCelular)", f_telPri: "\(recibo.telefonoPrincipal)", f_telSec: "\(recibo.telefonoSecundario)", f_recibido: false, f_comentario: "Ninguno")
                        }
                    }
                }
                UserDefaults.standard.set(fichas_prueba, forKey: "OrdenDeFichas")
            }
        }*/
    }
}

struct RecibosPorCobrarView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        RecibosPorCobrarView(fichas_prueba: $tempVar)
    }
}
