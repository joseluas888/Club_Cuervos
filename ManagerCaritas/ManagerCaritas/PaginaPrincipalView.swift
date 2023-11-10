//
//  PaginaPrincipalView.swift
//  ManagerCaritas
//
//  Created by Alumno on 05/11/23.
//


import SwiftUI

struct PaginaPrincipalView: View {
    var body: some View {
        VStack{
            TabView{
                Text("")
                    .tabItem {Label("Todos", systemImage: "chart.bar.fill")}
                Text("")
                    .tabItem {Label("Cobrados", systemImage: "dollarsign.circle.fill")}
                Text("")
                    .tabItem {Label("Comentarios", systemImage: "text.bubble")}
                Text("")
                    .tabItem {Label("No Cobrados", systemImage: "exclamationmark.triangle")}
                
            }
            Spacer()

            VStack{
                Text ("Resumen del día")
                    .padding()
                // Aquí es donde iría el contenido principal de tu página.
            }.frame(height: 730)
            
            TabView{
                Text("")
                    .tabItem {Label("Todos", systemImage: "chart.bar.fill")}
                Text("")
                    .tabItem {Label("Cobrados", systemImage: "dollarsign.circle.fill")}
            }.padding(.horizontal, 80.0)
            
        }
    }
}

struct PaginaPrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PaginaPrincipalView()
    }
}
