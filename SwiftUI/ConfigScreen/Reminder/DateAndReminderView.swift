//
//  DateAndReminderView.swift
//  CheckPointUI
//
//  Created by Pedro Rafael Madeira Vasconcelos on 01/10/23.
//

import SwiftUI

struct DateAndReminderView: View {
    
    var dateTitle: String //provavelmente tem que ser um array
    var reminderName: String //provavelmente tem que ser um array
    
    var body: some View {
        
//        Text("Lista de lembretes:")
//            .frame(width: 360, height: 10)
//            .font(.system(size: 24))
//            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 160))
        
        VStack {
            Text(dateTitle) //esse titulo pode se repetir mais vezes
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 220))
            
            HStack {
                Text(reminderName)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)
                Image(systemName: "x.square.fill")
                    .frame(width: 18.0, height: 18.0)
                    .foregroundColor(.red)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 70))
            HStack {
                Text(reminderName) //isso aqui tem que variar de acordo com a quantidade de lembretes
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)
                Image(systemName: "x.square.fill")
                    .frame(width: 18.0, height: 18.0)
                    .foregroundColor(.red)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 70))
        }
    }
}

