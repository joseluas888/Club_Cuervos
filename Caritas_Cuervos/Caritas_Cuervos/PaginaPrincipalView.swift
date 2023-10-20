//
//  PaginaPrincipalView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct PaginaPrincipalView: View {
    @State var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
    @State var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
    @State var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
    @State var mostrarConfirmacion:Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center){
            HeaderPrincipalView()
            ScrollView{
                LazyVStack{
                    ElementosPrincipalView()
                    ElementosPrincipalView(nombre: "Ángel Gael García Rangel", recibo: "2207", cantidad: "100.00")
                    ElementosPrincipalView(nombre: "Alejandro Fuentes Martínez", recibo: "2609", cantidad: "200.00")
                    ElementosPrincipalView(nombre: "José Elias Plascencia Cruz", recibo: "2908", cantidad: "300.00")
                    ElementosPrincipalView(nombre: "Nallely Lizbeth Serna Rivera", recibo: "2307", cantidad: "400.00")
                    ElementosPrincipalView(nombre: "José Alejandro Salazar Anza", recibo: "0912", cantidad: "500.00")
                }
            }
            Spacer()
        }
        .padding(.vertical)
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct PaginaPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PaginaPrincipalView()
    }
}
