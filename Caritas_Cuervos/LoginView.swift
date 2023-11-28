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
    @State private var isPasswordVisible = false
    
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

            HStack {
                // Contenedor para el campo de contraseña y el botón de visibilidad
                if isPasswordVisible {
                    TextField("Contraseña", text: $contrasena)
                        .font(.system(size: 23))
                        .padding(.leading, 40.0)
                        .padding(.top, 60.0)
                    
                    
                    
                } else {
                    SecureField("Contraseña", text: $contrasena) // SecureField para ocultar la contraseña
                        .font(.system(size: 23))
                        .padding(.leading, 40.0)
                        .padding(.top, 60.0)
                    
                    
                }
                
                Button(action: {
                    isPasswordVisible.toggle() // Alternar la visibilidad de la contraseña al hacer clic en el botón
                }) {
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .padding(.trailing, 25.0)
                        .padding(.top, 60.0)
                        .foregroundColor(.azul)
                }
                .padding(.trailing, 20.0)
            }
            
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            
            Button("Iniciar Sesión"){
                if contrasena == "" {
                    verificacion.toggle()
                }else{
                    // Llama a tu función CallAPIUsuario aquí
                    CallAPIUsuario(usuario, contrasena){login in
                        if login{
                            isNavigating = true
                        } else{
                            verificacion.toggle()
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
                    title: Text("Inicio de sesión incorrecto"),
                    message: Text("Los datos de inicio de sesión son incorrectos. Por favor, verifique sus credenciales."),
                    dismissButton: .default(Text("Aceptar"))
                )
            }
            .navigationDestination(isPresented: $isNavigating) {
                // Navega a tu vista principal aquí
                PaginaPrincipalView()
            }.navigationBarHidden(true)
            
            Spacer()
        }.background(Color.blanco)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
