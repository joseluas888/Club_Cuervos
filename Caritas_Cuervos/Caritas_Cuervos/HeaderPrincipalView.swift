//
//  HeaderPrincipalView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct HeaderPrincipalView: View {
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
    @State var texto:String = "Recibos por cobrar"
    
    var body: some View {
        VStack(alignment: .leading){
            Image("logo")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 150.0)
            HStack{
                Spacer()
            }
            Text("\(texto)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(negro)
                .padding(.leading)
        }
        .padding(.horizontal)
    }
}

struct HeaderPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPrincipalView()
    }
}
