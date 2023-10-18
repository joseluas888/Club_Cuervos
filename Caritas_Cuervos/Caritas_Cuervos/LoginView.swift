//
//  LoginView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 12/10/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var usuario = ""
    
    var body: some View {
        
        VStack{
            Spacer()
            Image("logo")
            Spacer()
            TextField("Usuario", text: $usuario)
                .font(.system(size: 25))
                .padding(.leading, 40.0)
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            TextField("Contraseña", text: $usuario)
                .font(.system(size: 25))
                .padding(.leading, 40.0)
                .padding(.top, 60.0)
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            
            Button("Iniciar Sesión"){
                
            }.buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
