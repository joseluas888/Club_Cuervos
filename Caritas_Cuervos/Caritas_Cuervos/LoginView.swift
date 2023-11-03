//
//  LoginView.swift
//  Caritas_Cuervos
//
//  Created by Alumno on 12/10/23.
//

import SwiftUI

extension Color{
    static let blanco = Color(red: 252 / 255, green: 250 / 255, blue: 245 / 255)
    static let azul = Color(red: 0 / 255, green: 144 / 255, blue: 161 / 255)
}

struct LoginView: View {
    
    @State private var usuario = ""
    @State private var contrasena = ""
    @State var isNavigating = false
    @State var verificacion = false
    
    
    var body: some View {
        
        VStack{
            Image("logo")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
                .padding()
            
            TextField("Usuario", text: $usuario)
                .font(.system(size: 23))
                .padding(.leading, 40.0)

            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            TextField("Contraseña", text: $contrasena)
                .font(.system(size: 23))
                .padding(.leading, 40.0)
                .padding(.top, 60.0)

            //Image(systemName: "eye.fill")
            //Image(systemName: "eye.slash")
            
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            
            Button("Iniciar Sesión"){
                if contrasena == ""{
                    verificacion.toggle()
                }
                else{
                    CallAPIUsuario(usuario, contrasena){
                        login in
                        if login {
                            isNavigating = true
                        }
                    }
                }
            }
            .font(.system(size: 25).bold())
            .frame(height: 60)
            .frame(width: 300)
            .background(Color.azul)
            .foregroundColor(Color.blanco)
            .cornerRadius(8)
            .alert(isPresented: $verificacion) {
                Alert(
                    title: Text("Contraseña en blanco"),
                    message: Text("El campo de contraseña no puede estar vacío"),
                    dismissButton: .default(Text("Aceptar"))
                )
            }
            .navigationDestination(isPresented: $isNavigating){
                PaginaPrincipalView()
            }
            
            
            Spacer()
        }.background(Color.blanco)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
