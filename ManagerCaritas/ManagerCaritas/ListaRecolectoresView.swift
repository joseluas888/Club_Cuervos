//
//  ListaRecolectoresView.swift
//  ManagerCaritas
//
//  Created by Alumno on 16/11/23.
//

import SwiftUI

struct ListaRecolectoresView: View {
    @State var collectors: [Collector] = []
    @State var col = 1
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
            }
            .frame(width: 500.0)
            .background(blanco)
            HeaderParaRecolectoresView()
            List {
                ForEach(collectors) { recolector in
                    NavigationLink(destination: TabRecibosView(id_recolector: recolector.idUsuario)) {
                        Text("\(recolector.nombre) \(recolector.apellidoPaterno)")
                            .font(.title2)
                            .padding(.vertical, 10.0)
                    }
                }
                .listRowBackground(blanco)
            }
            .padding(.top)
            .background(blanco)
            .listStyle(.plain)
            Spacer()
        }
        .background(blanco)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            getCollectors { retrievedCollectors, error in
                if let error = error {
                    print("Error obteniendo recolectores: \(error)")
                } else if let retrievedCollectors = retrievedCollectors {
                    self.collectors = retrievedCollectors
                }
            }
        }
    }

}

struct ListaRecolectoresView_Previews: PreviewProvider {
    static var previews: some View {
        ListaRecolectoresView()
    }
}
