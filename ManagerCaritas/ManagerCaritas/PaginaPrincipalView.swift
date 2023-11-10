//
//  PaginaPrincipalView.swift
//  ManagerCaritas
//
//  Created by Alumno on 05/11/23.
//


import SwiftUI

struct PaginaPrincipalView: View {
    @State private var selection = 0
    var body: some View {
        TabView {
            //
            VStack{
                VStack{
                    VStack{
                        TabView(selection: $selection){
                                    Text("")
                                        .onTapGesture {
                                            print("Todos")
                                        }
                                        .tabItem {
                                            Label("Todos", systemImage: "list.bullet")
                                        }
                                        .tag(0)

                                    Text("")
                                        .onTapGesture {
                                            print("Comentarios")
                                        }
                                        .tabItem {
                                            Label("Comentarios", systemImage: "text.bubble")
                                        }
                                        .tag(1)

                                    Text("")
                                        .onTapGesture {
                                            print("No Cobrados")
                                        }
                                        .tabItem {
                                            Label("No Cobrados", systemImage: "dollarsign.circle")
                                        }
                                        .tag(2)

                                    Text("")
                                        .onTapGesture {
                                            print("Cobrados")
                                        }
                                        .tabItem {
                                            Label("Cobrados", systemImage: "checkmark.seal")
                                        }
                                        .tag(3)
                                }
                        Divider()
                    }.offset(y: -680)
                    
                        
                }
                VStack{
                    Text("Pagina Principalll")
                    Text("Contenido")
                }.offset(y:-300)
            }
            //
                .tabItem {
                    Label("Principal", systemImage: "house")
                }
            
            RecibosDelDiaView()
                .tabItem {
                    Label("Recibos Del Dia", systemImage: "doc.text")
                }
        }
    }
}

struct PaginaPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PaginaPrincipalView()
    }
}
