//
//  PruebasView.swift
//  ManagerCaritas
//
//  Created by Alumno on 28/11/23.
//

import SwiftUI
import Charts


struct PruebasView: View {
    @StateObject var pieChartData = PieChartData()

    var body: some View {
        ScrollView {
            // ... Tu código existente para el encabezado y otras partes de la vista

            VStack {
                Text("Recibos totales")
                    .font(.headline)

                if !pieChartData.dataPie.isEmpty {
                    PieChartView(slices: pieChartData.dataPie, isDonut: true, hasGap: true)
                        .padding()

                    // Aquí puedes eliminar la sección VStack que muestra los detalles de los recibos
                    // Ya que ahora mostrarás los datos en el gráfico de pastel
                } else {
                    // Mensaje de carga o mensaje cuando no hay datos
                    Text("Cargando datos...")
                }

                Divider()
            }
            .padding()
        }
        .onAppear(perform: {
            // Llama al método fetchData en la instancia de PieChartData
            pieChartData.fetchData()
        })
    }
}
    


struct PruebasView_Previews: PreviewProvider {
    static var previews: some View {
        PruebasView()
    }
}


