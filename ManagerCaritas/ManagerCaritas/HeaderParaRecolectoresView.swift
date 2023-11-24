//
//  HeaderParaRecolectoresView.swift
//  ManagerCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

//Header reusado por varias pantallas (sólo es estética)
struct HeaderParaRecolectoresView: View {
    @State var texto:String = "Lista de recolectores"
    
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

struct HeaderParaRecolectoresView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderParaRecolectoresView()
    }
}

