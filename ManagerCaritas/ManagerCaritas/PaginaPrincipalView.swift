//
//  PaginaPrincipalView.swift
//  ManagerCaritas
//
//  Created by Alumno on 16/11/23.
//

import SwiftUI

//Colores acordes a la organizacion
var azul:Color = Color(red:0, green:0.5647058823529412, blue:0.6313725490196078)
var blanco:Color = Color(red:0.9882352941176471, green:0.9803921568627451, blue:0.9607843137254902)
var negro:Color = Color(red:0.17254901960784313, green:0.17254901960784313, blue:0.17254901960784313)
var naranja:Color = Color(red:1, green:0.4627450980392157, blue:0.17254901960784313)
var verde:Color = Color(red:0.792156862745098, green:0.8666666666666667, blue:0.8274509803921568)

struct PaginaPrincipalView: View {
    @State private var selectedTab: Tab = .recolectores
    @State private var showingLoginView = false
    @State private var showingLogoutConfirmation = false

    enum Tab {
        case recolectores
        case dashboards
    }

    var body: some View {
        NavigationView {
            NavigationStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        ListaRecolectoresView()
                            .tabItem {
                                Label("Recolectores", systemImage: "bicycle")
                                    .tag(Tab.recolectores)
                            }
                        DashboardsView()
                            .tabItem {
                                Label("Dashboards", systemImage: "chart.bar.fill")
                                    .tag(Tab.dashboards)
                            }
                    }
                    .onChange(of: selectedTab) { newTab in
                        // Oculta el botón cuando cambias a la pestaña Dashboards
                        if newTab == .dashboards {
                            showingLoginView = false
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if selectedTab == .recolectores {
                            Button(action: {
                                showingLogoutConfirmation = true
                            }) {
                                Image(systemName: "arrow.left")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color.black)
                            }
                            .alert(isPresented: $showingLogoutConfirmation) {
                                Alert(
                                    title: Text("Cerrar sesión"),
                                    message: Text("¿Estás seguro que quieres cerrar sesión?"),
                                    primaryButton: .default(Text("Sí")) {
                                        showingLoginView.toggle()
                                    },
                                    secondaryButton: .cancel(Text("No"))
                                )
                            }
                        }
                    }
                }
                .background(
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $showingLoginView) {
                        EmptyView()
                    }
                    .isDetailLink(false)
                    .hidden()
                )
            }
        }
        .onAppear {
            // Cambiar el color de la flecha de retroceso a negro
            UINavigationBar.appearance().tintColor = .black
        }
    }
}
