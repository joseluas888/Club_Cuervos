//
//  ElementosPrincipalView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct ElementosPrincipalView: View {
    @State var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
    @State var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
    @State var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
    @State var verde:Color = Color(red:0.792156862745098, green:0.8666666666666667, blue:0.8274509803921568)
    @State var nombre:String = "Nombre Nombre Apellido Apellido"
    @State var recibo:String = "000"
    @State var cantidad:String = "000.00"
    
    var body: some View {
        ZStack{
            VStack{
                
            }
            .padding(.all, 20.0)
            .frame(width: 350.0, height: 200.0)
            .background(blanco)
            .border(blanco)
            .shadow(radius: 5, x: 5, y: 5)
            
            VStack(alignment: .leading){
                Text("\(nombre)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(height: 60.0)
                    .foregroundColor(negro)
                
                HStack{
                    Text("Recibo: \(recibo)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(negro)
                    Spacer()
                    Text("$\(cantidad)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(naranja)
                }
                HStack{
                    NavigationLink(destination: DetallesDonanteView()){
                        Text("Ver información")
                    }
                    .frame(width: 145, height: 50.0)
                    .background(verde)
                    .foregroundColor(negro)
                    .cornerRadius(10)
                    .font(.footnote)
                    .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: ReciboView(nombre2: nombre, recibo2: recibo, cantidad2: cantidad)){
                        Text("Recolectar")
                    }
                    .frame(width: 140, height: 50.0)
                    .background(azul)
                    .foregroundColor(blanco)
                    .cornerRadius(10)
                    .font(.footnote)
                    .fontWeight(.bold)
                }
                .padding(.top, 5.0)
            }
            .padding(.all, 20.0)
            .frame(width: 350.0, height: 200.0)
            .background(blanco)
            .border(blanco)
        }
        .padding(.top, 20.0)
    }
}

struct ElementosPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        ElementosPrincipalView()
    }
}
