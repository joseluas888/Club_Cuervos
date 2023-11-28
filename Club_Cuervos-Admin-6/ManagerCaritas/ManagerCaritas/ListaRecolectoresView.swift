//
//  ListaRecolectoresView.swift
//  ManagerCaritas
//
//  Created by Alumno on 16/11/23.
//

import SwiftUI

struct Recolectores:Identifiable{
    let id = UUID()
    let name: String
}

struct ListaRecolectoresView: View {
    //Recolectores hardcodeados para pruebas
    var listaRecolectores:[Recolectores] = [
        Recolectores(name: "Juan"),
        Recolectores(name: "Alfonso"),
        Recolectores(name: "Xavier"),
        Recolectores(name: "Miguel"),
        Recolectores(name: "Mariano")]
    
    var body: some View {
        //NavigationStack{
            VStack(alignment: .center){
                HStack{Spacer()}
                    .frame(width: 500.0)
                    .background(blanco)
                HeaderParaRecolectoresView()
                List(){
                    //Desplegar cada nombre de recolector como un navigation link a la otra tab view (falta que asigne datos)
                    ForEach(listaRecolectores) {recolector in
                        NavigationLink(destination: TabRecibosView()){
                            Text("   \(recolector.name)")
                                .font(.title)
                                .padding(.vertical, 10.0)
                        }
                    }
                    .listRowBackground(blanco)
                }
                .padding(.top)
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
             }
             */
        //}
    }
}

struct ListaRecolectoresView_Previews: PreviewProvider {
    static var previews: some View {
        ListaRecolectoresView()
    }
}
