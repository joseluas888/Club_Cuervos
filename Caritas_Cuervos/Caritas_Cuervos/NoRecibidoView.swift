//
//  NoRecibidoView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct NoRecibidoView: View {
    @State var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
    @State var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
    @State var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
    @State var gris:Color = Color(red:0.8509803921568627, green:0.8509803921568627, blue:0.8509803921568627)
    @State var observaciones:String = ""
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
                
                TextField("Hola", text: $observaciones, axis: .vertical)
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
                
                Button(action:{dismiss()}){
                    Text("Confirmar observaciones")
                        .padding(.horizontal, 10.0)
                        .foregroundColor(azul)
                        .frame(width:335, height: 80.0)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(azul, lineWidth: 3))
                    }
                    .background(blanco)
                    .cornerRadius(20.0)
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
        NoRecibidoView()
    }
}
