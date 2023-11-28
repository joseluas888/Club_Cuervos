//
//  HeaderGraficasView.swift
//  ManagerCaritas
//
//  Created by Alumno on 21/11/23.
//

import SwiftUI

struct HeaderGraficasView: View {
    
    @State var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
        @State var texto:String = "Gráficas"
        
        var body: some View {
            VStack{
                Text("\(texto)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(negro)
                    .padding(.leading)
    
            }
            
        }
    }

struct HeaderGraficasView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderGraficasView()
    }
}

