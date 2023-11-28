//
//  PruebasView.swift
//  ManagerCaritas
//
//  Created by Alumno on 28/11/23.
//

import SwiftUI
import Charts



struct Receipt:Decodable {
    let estadoCobro: String
    let cantidad: Int
}


struct PruebasView: View {
    
    
    var cobrados:String = "Cobrados - 80"
    var nocobrados:String = "No cobrados - 20"
    
    //Grfica de pastel
    var dataPie = [
        (98.0, Color.azulito),
        (19.0, naranja)
        
    ]
    
    
    var body: some View {
        ScrollView{
            //Header
            VStack(alignment: .leading){
                HeaderGraficasView(texto: "Información")
                    .padding(.top, 10.0)
                    .padding(.leading, 10.0)
                Divider()
                
                
                //Grafica de pastel
                VStack{
                    
                    Text("Recibos totales")
                        .font(.headline)
                    
                    
                    HStack{
                        PieChartView(slices: dataPie, isDonut: true, hasGap: true)
                            .padding()
                        
                        
                        VStack{
                            
                            Text(cobrados)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(5)
                                .foregroundColor(.azulito)
                                .bold()
                            Text(nocobrados)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(5)
                                .foregroundColor(naranja)
                                .bold()
                        }
                        onAppear {
                                    getPaidUnpaidReceipts { receipts, error in
                                        if let receipts = receipts {
                                            // Actualizar los datos en la vista con los datos obtenidos
                                            // Aquí puedes actualizar cobrados, nocobrados, dataPie, etc.
                                            // Por ejemplo:
                                            let totalReceipts = receipts.reduce(0) { $0 + $1.cantidad }
                                            let paid = receipts.filter { $0.estadoCobro == "Pagado" }.count
                                            let unpaid = totalReceipts - paid

                                            cobrados = "Cobrados - \(paid)"
                                            nocobrados = "No cobrados - \(unpaid)"
                                            
                                            // Actualizar la gráfica de pastel con los nuevos datos
                                            dataPie = [
                                                (Double(paid), Color.green), // Por ejemplo, usar verde para los cobrados
                                                (Double(unpaid), Color.red) // Rojo para los no cobrados
                                            ]
                                        } else if let error = error {
                                            // Manejar el error, por ejemplo, mostrar una alerta
                                            print("Error obteniendo datos: \(error.localizedDescription)")
                                        }
                                    }
                                }
                    }
                    Divider()
                }.padding()
            }
        }
    }
}

struct PruebasView_Previews: PreviewProvider {
    static var previews: some View {
        PruebasView()
    }
}

