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
                    ElementosPrincipalView()
                    ElementosPrincipalView()
                    ElementosPrincipalView()
                    ElementosPrincipalView()
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
