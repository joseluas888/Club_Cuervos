//
//  ContentView.swift
//  ManagerCaritas
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                PaginaPrincipalView()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
