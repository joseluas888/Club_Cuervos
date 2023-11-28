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
            //Header
            VStack(alignment: .leading){
                HeaderGraficasView(texto: "Información")
                    .padding(.top, 10.0)
                    .padding(.leading, 10.0)
                Divider()
            }

            VStack {
                Text("Recibos totales")
                    .font(.headline)
                
                if !pieChartData.dataPie.isEmpty {
                    VStack{
                        
                        HStack{
                            PieChartView(slices: pieChartData.dataPie, isDonut: true, hasGap: true)
                                .padding()
                            VStack{

                                HStack{
                                    Text("Cobrados")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        .padding(5)
                                        .foregroundColor(.azulito)
                                        .bold()
                                    
                                    Text("\(String(format: "%.0f", pieChartData.dataPie[0].0))")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        .padding(5)
                                        .foregroundColor(.red)
                                        .bold()
                                }

                                HStack{
                                    Text("No Cobrados")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        .padding(5)
                                        .foregroundColor(naranja)
                                        .bold()
                                    
                                    Text("\(String(format: "%.0f", pieChartData.dataPie[1].0))")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        .padding(5)
                                        .foregroundColor(naranja)
                                        .bold()
                                }

                                HStack{
                                    Text("Promesa")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        .padding(5)
                                        .foregroundColor(morado)
                                        .bold()
                                    
                                    Text("\(String(format: "%.0f", pieChartData.dataPie[2].0))")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        .padding(5)
                                        .foregroundColor(morado)
                                        .bold()
                                }

                                
                            }
                        }

                    }
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


