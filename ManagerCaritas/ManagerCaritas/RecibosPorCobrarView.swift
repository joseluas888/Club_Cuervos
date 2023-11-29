//
//  RecibosPorCobrarView.swift
//  ManagerCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

struct RecibosPorCobrarView: View {
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_pagadas:[Ficha]
    @Binding var fichas_noPagadas:[Ficha]
    @Binding var id_recolector:Int
    
    var body: some View {
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            HeaderParaRecolectoresView(texto: "Recibos por cobrar")
            List(){
                ForEach(fichas_porCobrar) { ficha in
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
        .onAppear{
            if(self.fichas_porCobrar.count == 0){
                fetchRecibos(forUserID: id_recolector) { recibos in
                    if let recibos = recibos {
                        let fichas_holder = recibos.map { recibo in
                            let ficha_holder = Ficha(id: recibo.folioRecibo, f_direccion: "\(recibo.calle) \(recibo.numero), \(recibo.municipio)",f_nombre: "\(recibo.nombre) \(recibo.apellidoPaterno) \(recibo.apellidoMaterno)", f_folio: "\(recibo.folioRecibo)", f_cantidad: "\(recibo.monto)", f_referencias: recibo.referencias, f_detalles: recibo.detalles, f_telCel: "\(recibo.telefonoCelular)", f_telPri: "\(recibo.telefonoPrincipal)", f_telSec: "\(recibo.telefonoSecundario)", f_recibido: recibo.cobrado == 1, f_comentario: recibo.comentarios ?? "Ninguno")
                            if(ficha_holder.f_recibido == false && ficha_holder.f_comentario == "Ninguno"){
                                fichas_porCobrar.append(ficha_holder)
                            }
                            else if(ficha_holder.f_recibido == true){
                                fichas_pagadas.append(ficha_holder)
                            }
                            else{
                                fichas_noPagadas.append(ficha_holder)
                            }
                            return ficha_holder
                        }
                    }
                }
            }
        }
    }
}

struct RecibosPorCobrarView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        @State var tempVar2:[Ficha] = []
        @State var tempVar3:[Ficha] = []
        @State var tempVar4:Int = 1
        RecibosPorCobrarView(fichas_porCobrar: $tempVar, fichas_pagadas: $tempVar2, fichas_noPagadas: $tempVar3, id_recolector: $tempVar4)
    }
}
