//
//  GraficasView.swift
//  ManagerCaritas
//
//  Created by Alumno on 21/11/23.
//

import SwiftUI
import Charts

extension Color{
    public static var negro: Color{
        return Color(UIColor(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313, alpha: 1.0))
    }
    public static var azulito: Color{
        return Color(UIColor(red: 0 / 255, green: 144 / 255, blue: 161 / 255, alpha: 1.0))
    }
}

struct DashboardsView: View {
    
    
    var cobrados:String = "Cobrados - 80"
    var nocobrados:String = "No cobrados - 20"
    
    
    //Grfica de pastel
    let dataPie = [
        (98.0, Color.azulito),
        (19.0, naranja)
        
    ]

    //Grafica de barras
    let dataBarChart: [Zona] = [
        Zona(id:1, tipo: "Escobedo", votos: 15),
        Zona(id:2, tipo: "San Pedro", votos: 8),
        Zona(id:3, tipo: "San Nicolás", votos: 10),
        Zona(id:4, tipo: "Guadalupe", votos: 3),
        Zona(id:5, tipo: "Cumbres", votos: 7),
    ]
    
    //Grafica de linea
    let dataLinesXY = [
        Punto(x:0, y:0),
        Punto(x:1, y:80),
        Punto(x:2, y:20),
        Punto(x:3, y:100)

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
                    }
                    Divider()
                }.padding()
                
                
                //Grafica de barras
                VStack{
                    
                    Text("Cantidad de recibos cobrados")
                        .font(.headline)
                        .padding()
                    
                    Chart(dataBarChart) {item in
                        BarMark(
                            x: .value("Comida", item.tipo),
                            y: .value("Votos", item.votos)
                        )
                    }
                    .frame(height: 150)
                    .foregroundColor(.azul)
                    .padding()
                    
                    
                    Divider()
                        .padding()
                }
                
                //Grafica de puntos
                VStack{
                    
                    Text("Importe de los recibos")
                        .font(.headline)
                        .padding()
                    
                    Chart(dataLinesXY) { item in
                        LineMark(
                            x: .value("Meses", item.x),
                            y: .value("Votos", item.y)
                        )
                    }.padding()
                    .frame(height: 150)
                    .foregroundColor(naranja)
                    
                    
                }
                Divider()
                    .padding()
                
                
                
                
            }
            
        }
    }
}

//Grafica de barras
 struct Zona: Identifiable{
    let id: Int
    let tipo: String
    let votos: Double
     
 }

//Grafica de lineas
struct Punto: Identifiable {
    let id: Int
    let x: Int
    let y: Double
    init(x: Int, y: Double) {
        self.id = x
        self.x = x
        self.y = y
    }
}

        
struct DashboardsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardsView()
    }
}

