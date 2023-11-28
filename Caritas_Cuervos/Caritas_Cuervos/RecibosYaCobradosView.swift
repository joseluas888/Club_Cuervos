//
//  RecibosYaCobradosView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct RecibosYaCobradosView: View {
    @Binding var fichas_cobradas:[Ficha]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View{
        VStack(alignment: .center){
            HStack{Spacer()}
                .frame(width: 500.0)
                .background(blanco)
            ZStack{
                HeaderPrincipalView(texto: "Recibos ya cobrados")
                HStack{
                    Spacer()
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(azul)
                            .padding(.leading, 20.0)
                            .frame(width: 60.0)
                    }
                    .padding([.bottom, .trailing], 35.0)
                }
            }
            List(){
                ForEach(fichas_cobradas) { ficha in
                    ElementosYaCobradosView(direccion: ficha.f_direccion, nombre: ficha.f_nombre, folio: ficha.id, cantidad: ficha.f_cantidad, comentario: ficha.f_comentario, telFijo: ficha.f_telPri, telExtra: ficha.f_telSec, telCelular: ficha.f_telCel, recibido: ficha.f_recibido)
                }
                .listRowBackground(blanco)
            }
            .background(blanco)
            .listStyle(.plain)
            Spacer()
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
    }
}

struct RecibosYaCobradosView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tempVar:[Ficha] = []
        RecibosYaCobradosView(fichas_cobradas: $tempVar)
    }
}
