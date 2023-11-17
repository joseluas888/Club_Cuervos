//
//  ReciboView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct ReciboView: View {
    @ObservedObject var modalState:ModalState
    
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_cobradas:[Ficha]
    @State var fichaIndex:Int = 0
    
    @State var mostrarConfirmacion:Bool = false
    @State var nombre:String = "Nombre Nombre Apellido Apellido"
    @State var folio:Int = 0
    @State var cantidad:String = "000.00"
    //@Binding var comentario:String
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
            HeaderReciboView(texto: "Recibo")
                .padding(.top, 10.0)
            VStack(alignment: .leading){
                Text("\(nombre)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(negro)
                    .padding(.vertical, 10.0)
                    .frame(height: 100.0)
                Text(verbatim: "Recibo: \(folio)")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(negro)
                    .padding(.leading, 10.0)
                HStack{
                    Text("Total")
                        .font(.title2)
                        .foregroundColor(negro)
                        .padding(.leading, 10.0)
                    Spacer()
                    Text("$\(cantidad)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing, 10.0)
                        .foregroundColor(naranja)
                }
                .padding(.vertical, 10.0)
                Divider()
                    .frame(height: 1.0)
                    .background(negro)
                HStack{
                    //NavigationLink(destination:NoRecibidoView(fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, folio: self.folio)){
                    Button("No recibi el dinero"){
                        self.modalState.isModal2Present = true
                        //Text("No recibí el dinero")
                            //.padding(.horizontal, 10.0)
                            //.foregroundColor(azul)
                            //.frame(width: 150.0, height: 75.0)
                            //.overlay(RoundedRectangle(cornerRadius: 20)
                            //.stroke(azul, lineWidth: 3))
                    }
                    .background(blanco)
                    .cornerRadius(10.0)
                    .padding(.horizontal, 10.0)
                    .foregroundColor(azul)
                    .frame(width: 150.0, height: 75.0)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(azul, lineWidth: 2))
                    .sheet(isPresented: $modalState.isModal2Present){
                        NoRecibidoView(modalState: self.modalState, fichas_porCobrar: self.$fichas_porCobrar, fichas_cobradas: self.$fichas_cobradas, folio: self.folio)
                    }
                    
                    Spacer()
                    
                    Button("Dinero recolectado"){
                        mostrarConfirmacion.toggle()
                    }
                    .frame(width: 150)
                    .frame(height: 75)
                    .background(azul)
                    .foregroundColor(blanco)
                    .cornerRadius(20)
                    .fontWeight(.bold)
                    .alert(isPresented: $mostrarConfirmacion) {
                        Alert(
                            title: Text("¿Deseas guardar la información?"),
                            message: Text("No podrás modificar este recibo tras guardar la información"),
                            primaryButton: .cancel(
                                Text("Cancelar")),
                            secondaryButton: .default(
                                Text("Aceptar"),
                                action: {
                                    if let fichaActual = fichas_porCobrar.firstIndex(where: {$0.id == folio}){
                                        fichaIndex = fichaActual
                                    }
                                    var fichaActual = fichas_porCobrar.remove(at: fichaIndex)
                                    fichaActual.f_recibido.toggle()
                                    fichas_cobradas.append(fichaActual)
                                    markReceiptAsPaid(folioRecibo: fichaActual.id) { success, error in
                                        if success {
                                            print("El recibo se actualizó como PAGADO")
                                        } else {
                                            print("Error al actualizar el estado del recibo")
                                        }
                                    }
                                    dismiss()
                                })
                        )
                    }
                }
                .padding(.top, 30.0)
            }
            .padding(.horizontal, 30.0)
            Spacer()
        }
        .padding(.top, 30.0)
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct ReciboView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        @State var tempVar2:[Ficha] = []
        @State var tempVar3 = ModalState()
        ReciboView(modalState: tempVar3, fichas_porCobrar: $tempVar, fichas_cobradas: $tempVar2)
    }
}
