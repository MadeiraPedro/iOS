//
//  DateExtension.swift
//  Reminder
//
//  Created by Pedro Madeira on 04/10/23.
//

import Foundation

extension Date {
    
 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
}
