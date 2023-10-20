//
//  ReciboView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct ReciboView: View {
    @State var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
    @State var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
    @State var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
    @State var mostrarConfirmacion:Bool = false
    @State var nombre2:String = "Nombre Nombre Apellido Apellido"
    @State var recibo2:String = "000"
    @State var cantidad2:String = "$000.00"
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
                Text("\(nombre2)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(negro)
                    .padding(.vertical, 10.0)
                    .frame(height: 100.0)
                Text("Recibo: \(recibo2)")
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
                    Text("\(cantidad2)")
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
                    NavigationLink(destination:NoRecibidoView()){
                        Text("No recibí el dinero")
                            .padding(.horizontal, 10.0)
                            .foregroundColor(azul)
                            .frame(width: 150.0, height: 75.0)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(azul, lineWidth: 3))
                    }
                    .background(blanco)
                    .cornerRadius(20.0)
                    
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
                                action: {dismiss()})
                        )
                    }
                }
                .padding(.top, 30.0)
            }
            .padding(.horizontal, 30.0)
            Spacer()
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct ReciboView_Previews: PreviewProvider {
    static var previews: some View {
        ReciboView()
    }
}
