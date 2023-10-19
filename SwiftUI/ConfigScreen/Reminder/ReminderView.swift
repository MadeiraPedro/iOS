//
//  ReminderView.swift
//  CheckPointUI
//
//  Created by Pedro Rafael Madeira Vasconcelos on 01/10/23.
//

import SwiftUI

struct ReminderView: View {
    
    /*
     Preciso de 3 variaveis pelo menos
     uma de nome da tarfe
     outra de data (formatar ela)
     */
    
    @State private var name: String = ""
    @State private var date: String = ""
    
    @State private var isTapping: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Group {
                    HStack {
                        Text("Nome")
                            .frame(width: 60, height: 30)
                            .background(Color.gray)
                            .cornerRadius(5)
                        TextField("Ex: Ir comprar pão", text: $name)
                            .border(.gray)
                            .frame(width: 300.0, height: 10.0)
                    }
                    
                    HStack {
                        Text("Data")
                            .frame(width: 60, height: 30)
                            .background(Color.gray)
                            .cornerRadius(5)
                        TextField("Ex: dd/mm/aaaa", text: $date)
                            .border(.gray)
                            .frame(width: 300.0, height: 10.0)
                    }
                    
                    Button {
                        isTapping = true
                    } label: {
                        Text("Criar")
                            .frame(width: 60, height: 40)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(8)
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                
                ScrollView(.vertical) {
                    if isTapping {
                        Text("Lista de lembretes:")
                            .frame(width: 360, height: 10)
                            .font(.system(size: 24))
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 160))
                        
                        teste(name, date)
                    }
                }
//                DateAndReminderView(dateTitle: "01/10/2023", reminderName: "Exemplo de Lembrete")
                
//                Text("Nome: \(name)")
//                Text("Data: \(date)")
            }
            .navigationTitle(Text("Novo lembrete"))
        }
        
    }
    
    @ViewBuilder
    private func teste(_ name: String?, _ data: String?) -> some View {
        if let name, let data {
            DateAndReminderView(dateTitle: data, reminderName: name)
        }
    }
    
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}

