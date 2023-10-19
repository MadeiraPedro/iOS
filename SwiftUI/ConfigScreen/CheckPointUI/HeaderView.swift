//
//  HeaderView.swift
//  CheckPointUI
//
//  Created by Pedro Rafael Madeira Vasconcelos on 28/09/23.
//

import SwiftUI

struct HeaderView: View {
    
    var textColor: Color
    var sectionBackgroundColor: Color
    
    var body: some View {
        Section {
            HStack {
                Image("perfil")
                    .resizable()
                    .frame(width: 70.0, height: 70.0)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(50.0)
                VStack {
                    Text("Pedro Madeira")
                        .font(.title)
                        .frame(alignment: .leading)
                        .foregroundColor(textColor)
                    Text("ID Apple, iCloud+, Mídia e Compras")
                        .font(.system(size: 11.0))
                        .foregroundColor(textColor)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }.onTapGesture {
                print("cliclou")
            }
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(sectionBackgroundColor)
    }
}

