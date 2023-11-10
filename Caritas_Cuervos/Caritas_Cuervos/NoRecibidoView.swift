//
//  NoRecibidoView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct NoRecibidoView: View {
    @Binding var fichas_porCobrar:[Ficha]
    @Binding var fichas_cobradas:[Ficha]
    @State var fichaIndex:Int = 0
    
    @State var gris:Color = Color(red:0.8509803921568627, green:0.8509803921568627, blue:0.8509803921568627)
    @State var observaciones:String = ""
    @State var folio:Int = 0
    @State var mostrarAdvertencia:Bool = false
    @State var mostrarConfirmacion:Bool = false
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
            HeaderReciboView(texto: "Recibo no cobrado")
                .padding(.top, 10.0)
            VStack(alignment: .leading){
                Text("Observaciones")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(negro)
                    .padding(.top, 30.0)
                
                TextField("", text: $observaciones, axis: .vertical)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(gris)
                    .multilineTextAlignment(.leading)
                    .lineLimit(8, reservesSpace: true)
                    .cornerRadius(5)
                
                Divider()
                    .frame(height: 1.0)
                    .background(negro)
                    .padding(.vertical, 20.0)
                
                Button(action:{
                    if observaciones == ""{
                        mostrarAdvertencia.toggle()
                    }
                    else{
                        mostrarAdvertencia.toggle()
                        mostrarConfirmacion.toggle()
                    }
                }){
                    Text("Confirmar observaciones")
                        .padding(.horizontal, 10.0)
                        .foregroundColor(azul)
                        .frame(width:335, height: 80.0)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(azul, lineWidth: 3))
                }
                .background(blanco)
                .cornerRadius(20.0)
                .alert(isPresented: $mostrarAdvertencia) {
                    if(mostrarConfirmacion == false){
                        return Alert(
                            title: Text("Observaciones en blanco"),
                            message: Text("Falta agregar las observaciones del recibo no cobrado"),
                            dismissButton: .default(Text("Aceptar"))
                        )
                    }
                    else{
                        return Alert(
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
                                    fichaActual.f_comentario = self.observaciones
                                    fichas_cobradas.append(fichaActual)
                                    dismiss()
                                })
                        )
                    }
                }
            }
            .padding(.horizontal, 30.0)
            Spacer()
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct NoRecibidoView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        @State var tempVar2:[Ficha] = []
        @State var tempVar3:String = ""
        NoRecibidoView(fichas_porCobrar: $tempVar, fichas_cobradas: $tempVar2)
    }
}
