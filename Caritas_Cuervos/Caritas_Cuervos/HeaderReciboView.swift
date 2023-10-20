//
//  HeaderReciboView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct HeaderReciboView: View {
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
    @State var texto:String = "Recibo"
    
    var body: some View {
        VStack{
            Text("\(texto)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(negro)
            Image("caritas")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct HeaderReciboView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderReciboView()
    }
}
