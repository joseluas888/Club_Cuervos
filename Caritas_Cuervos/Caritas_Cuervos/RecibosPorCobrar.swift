//
//  RecibosPorCobrar.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI
import CoreMotion

struct RecibosPorCobrar: View {
    @StateObject var modalState = ModalState()
    
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_cobradas:[Ficha]
    @Binding var g_nombre:String
    @Binding var g_folio:Int
    @Binding var g_cantidad:String
    @Environment(\.dismiss) private var dismiss
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State var fichaIndex:Int = 0
    
    var body: some View {
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            ZStack{
                HeaderPrincipalView()
                HStack{
                    Spacer()
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(azul)
                            .padding(.leading, 20.0)
                            .frame(width: 60.0)
                    }
                    .padding(.bottom, 35.0)
                    .padding(.trailing, 25.0)
                }
            }
            .onAppear{
                print("ON APPEAR")
                motionManager.accelerometerUpdateInterval = 1/10
                self.motionManager.startAccelerometerUpdates(to: self.queue) {accelerometerData, error in
                    guard let error = error else {
                        print("dentro")
                        print("x: \(accelerometerData?.acceleration.x ?? 0)")
                        print("y: \(accelerometerData?.acceleration.y ?? 0)")
                        print("z: \(accelerometerData?.acceleration.z ?? 0)")
                        if(accelerometerData?.acceleration.y ?? 0 < -3.0){
                            print("here")
                            self.fichas_porCobrar.removeAll()
                            fetchRecibos(forUserID: 1) { recibos in
                                if let recibos = recibos {
                                    let fichas_holder = recibos.map { recibo in
                                        let ficha_holder = Ficha(id: recibo.folioRecibo, f_direccion: "\(recibo.calle) \(recibo.numero), \(recibo.municipio)",f_nombre: "\(recibo.nombre) \(recibo.apellidoPaterno) \(recibo.apellidoMaterno)", f_folio: "\(recibo.folioRecibo)", f_cantidad: "\(recibo.monto)", f_referencias: recibo.referencias, f_detalles: recibo.detalles, f_telCel: "\(recibo.telefonoCelular)", f_telPri: "\(recibo.telefonoPrincipal)", f_telSec: "\(recibo.telefonoSecundario)", f_recibido: recibo.cobrado == 1, f_comentario: recibo.comentarios ?? "Ninguno")
                                        if(ficha_holder.f_recibido == false && ficha_holder.f_comentario == "Ninguno"){
                                            fichas_porCobrar.append(ficha_holder)
                                        }
                                        return ficha_holder
                                    }
                                }
                            }
                        }
                        return
                    }
                }
            }
            List(){
                ForEach(fichas_porCobrar) { ficha in
                    ElementosPrincipalView(modalState: self.modalState, fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, g_nombre: self.$g_nombre, g_folio: self.$g_folio, g_cantidad: self.$g_cantidad, direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.id, cantidad: ficha.f_cantidad, ref: ficha.f_referencias, detalles: ficha.f_detalles, telFijo: ficha.f_telPri, telExtra: ficha.f_telSec, telCelular: ficha.f_telCel)
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
        .onAppear{
            if(fichas_porCobrar.count == 0){
                fetchRecibos(forUserID: 1) { recibos in
                    if let recibos = recibos {
                        let fichas_holder = recibos.map { recibo in
                            let ficha_holder = Ficha(id: recibo.folioRecibo, f_direccion: "\(recibo.calle) \(recibo.numero), \(recibo.municipio)",f_nombre: "\(recibo.nombre) \(recibo.apellidoPaterno) \(recibo.apellidoMaterno)", f_folio: "\(recibo.folioRecibo)", f_cantidad: "\(recibo.monto)", f_referencias: recibo.referencias, f_detalles: recibo.detalles, f_telCel: "\(recibo.telefonoCelular)", f_telPri: "\(recibo.telefonoPrincipal)", f_telSec: "\(recibo.telefonoSecundario)", f_recibido: recibo.cobrado == 1, f_comentario: recibo.comentarios ?? "Ninguno")
                            if(ficha_holder.f_recibido == false && ficha_holder.f_comentario == "Ninguno"){
                                fichas_porCobrar.append(ficha_holder)
                            }
                            else{
                                fichas_cobradas.append(ficha_holder)
                            }
                            return ficha_holder
                        }
                    }
                }
                UserDefaults.standard.set(fichas_porCobrar, forKey: "OrdenDeFichas")
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        fichas_porCobrar.move(fromOffsets: source, toOffset: destination)
    }
}

struct RecibosPorCobrar_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        @State var tempVar2:[Ficha] = []
        @State var tempVar3:String = ""
        @State var tempVar4:Int = 0
        @State var tempVar5:String = ""
        RecibosPorCobrar(fichas_porCobrar: $tempVar, fichas_cobradas: $tempVar2, g_nombre: $tempVar3, g_folio: $tempVar4, g_cantidad: $tempVar5)
    }
}
