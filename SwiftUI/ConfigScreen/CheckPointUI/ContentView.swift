//
//  ContentView.swift
//  CheckPointUI
//
//  Created by Pedro Rafael Madeira Vasconcelos on 02/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var airplaneState = false
    @State private var darkModeState: Bool = false
    
    @State private var textColor = Color.black
    @State private var sectionBackgroundColor = Color(uiColor: .systemBackground)
    @State private var backgroundColor = Color(cgColor: CGColor(gray: 0.93, alpha: 0.9))
    
    private let lightGrayColor = Color(cgColor: CGColor(gray: 0.93, alpha: 0.9))
    private let darkGrayColor = Color(cgColor: CGColor(gray: 0.1, alpha: 1))
    
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
//                Section {
//                    HStack {
//                        Text("Ajustes")
//                            .foregroundColor(textColor)
//                            .font(.largeTitle)
//                        Spacer()
//                    }
//                }
//                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
//                .background(darkModeState ? .black : Color(cgColor: CGColor(gray: 0.935, alpha: 0.9)))
                
                // MARK: Header View
                HeaderView(textColor: textColor, sectionBackgroundColor: sectionBackgroundColor)
                
                Section {
                    HStack {
                        Image(systemName: "airplane")
                            .frame(width: 28.0, height: 28.0)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(6.0)
                        Text("Modo Avião")
                            .foregroundColor(textColor)
                        Toggle("", isOn: $airplaneState)
                            .onTapGesture {
                                airplaneState = !airplaneState
                            }
                    }
                    
                    HStack {
                        Image(systemName: "wifi")
                            .frame(width: 28.0, height: 28.0)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(6.0)
                        Text("Wi-Fi")
                            .foregroundColor(textColor)
                        Spacer()
                        Text("Madeira Home")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        print("Clicou wi-fi")
                    }
                    
                    HStack {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .frame(width: 28.0, height: 28.0)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(6.0)
                        Text("Celular")
                            .foregroundColor(textColor)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }.onTapGesture {
                        print("Clicou Phone")
                    }
                    HStack {
                        Image(systemName: "personalhotspot")
                            .frame(width: 28.0, height: 28.0)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(6.0)
                        Text("Acesso Pessoal")
                            .foregroundColor(textColor)
                        Spacer()
                        Text("Desativado")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }.onTapGesture {
                        print("Clicou Acesso Pessoal")
                    }
                }
                .padding(8)
                .background(sectionBackgroundColor)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Section {
                    HStack {
                        Image(systemName: "lightbulb")
                            .frame(width: 28.0, height: 28.0)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(6.0)
                        Text("Dark Mode")
                            .foregroundColor(textColor)
                        Spacer()
                        Toggle("", isOn: $darkModeState)
                            .onChange(of: darkModeState, perform: { newValue in
                                changeTheme(newValue)
                            })
                        
                    }.onTapGesture {
                        print("Clicou DarkMode")
                    }
                }
                .padding(8)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(sectionBackgroundColor)
                
                NavigationLink(destination: AnimationView()) {
                    Image(systemName: "timelapse")
                        .frame(width: 28.0, height: 28.0)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(6.0)
                    Text("AnimationView")
                        .foregroundColor(textColor)
                }
                .padding(8)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(sectionBackgroundColor)
                
                Section {
                    Picker("Silenciar Notificações", selection: .constant(1)) {
                        Text("Nunca").tag(1)
                        Text("por 1 hora").tag(2)
                        Text("por 1 Semana").tag(3)
                        Text("por 1 ano").tag(4)
                        Text("Sempre").tag(5)
                    }.foregroundColor(textColor)
                }
                .padding(8)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(sectionBackgroundColor)
                
            }
            .scrollContentBackground(.hidden)
            .background(backgroundColor)
            .navigationBarTitle("Ajustes")
        }
    }
    
//    @ViewBuilder
//    private func header() -> some View {
//        Section {
//            HStack {
//                Image("perfil")
//                    .resizable()
//                    .frame(width: 70.0, height: 70.0)
//                    .aspectRatio(contentMode: .fill)
//                    .cornerRadius(50.0)
//                VStack {
//                    Text("Pedro Madeira")
//                        .font(.title)
//                        .frame(alignment: .leading)
//                        .foregroundColor(textColor)
//                    Text("ID Apple, iCloud+, Mídia e Compras")
//                        .font(.system(size: 11.0))
//                        .foregroundColor(textColor)
//                }
//                Spacer()
//                Image(systemName: "chevron.right")
//                    .foregroundColor(.gray)
//            }.onTapGesture {
//                print("cliclou")
//            }
//        }
//        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
//        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//        .background(sectionBackgroundColor)
//    }
    
    private func changeTheme(_ isDark: Bool) {
        if isDark {
            textColor = .white
            sectionBackgroundColor = darkGrayColor
            backgroundColor = .black
        } else {
            textColor = .black
            sectionBackgroundColor = .white
            backgroundColor = lightGrayColor
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

