//
//  ReminderViewModel.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit


public class ReminderViewModel {
    
    private enum Metrics {
        static let dateSize = 10
        static let minimumNameSize = 3
    }
    
    private enum Constants {
        static let alertButtonText = "Entendi"
        static let alertMenssage = "Ops, Tivemos um erro! \nVerifique se todos os campos foram preenchidos corretamente"
        static let alertDateInPast = "Ops, Tivemos um erro! \nA data inserida não pode estar no passado"
        static let alertInvalidNameLength = "Ops, Tivemos um erro! \nVerifique o campo nome precisa ter um pelo menos 3 caracteres"
        static let alertSameTaskOnDate = "Ops, Tivemos um erro! \nParece que voce ja tem um lembrete igual nesta data."
        
        static let dateFormat = "dd/MM/yyyy"
    }
    
    public weak var viewController: ReminderViewController?
    private var viewEntity: [ReminderViewEntity] = []
          
    public func createReminder(stringDate: String?, name: String?, _ entity: [ReminderViewEntity]?) {
        guard let date = stringToDate(stringDate: stringDate), let name else {
            showError(menssage: Constants.alertMenssage)
            return
        }
        
        if let entity {
            self.viewEntity = entity
        }
                
        if validateName(name: name) && validadeSameTaskOnDate(name: name, date: date) {
            updateRemindersEntity(name: name, date: date)
        }
    }
    
    private func stringToDate(stringDate: String?) -> Date? {
        guard let stringDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        
        if let inputDate = dateFormatter.date(from: stringDate), let currentDate = dateFormatter.date(from: Date.getCurrentDate()) {
            if inputDate >= currentDate {
                return inputDate
            }
            showError(menssage: Constants.alertDateInPast)
        }
        return nil
    }
    
    private func validateName(name: String) -> Bool {
        if name.count < Metrics.minimumNameSize {
            showError(menssage: Constants.alertInvalidNameLength)
            return false
        }
        return true
    }
        
    private func validadeSameTaskOnDate(name: String, date: Date) -> Bool {
        if let cellRows = viewEntity.first(where: { $0.sectionTitle == date })?.cellRows {
            if cellRows.contains(name) {
                showError(menssage: Constants.alertSameTaskOnDate)
                return false
            }
        }
        return true
    }
    
    func chronologicalDate() -> [ReminderViewEntity] {
        let newEntity = viewEntity.sorted(by: { $0.sectionTitle?.compare($1.sectionTitle ?? .distantPast) == .orderedAscending })
        return newEntity
    }
    
    private func updateRemindersEntity(name: String, date: Date) {
        let section = ReminderViewEntity(sectionTitle: date, cellRows: [name])
        
        if viewEntity.count == .zero {
            viewEntity.append(section)
            viewController?.updateView(entity: viewEntity)
            return
        }
                
        for index in 0...(viewEntity.count-1) {
            if viewEntity[index].sectionTitle == date {
                viewEntity[index].cellRows?.append(name)
                viewController?.updateView(entity: viewEntity)
                return
            }
        }
        
        viewEntity.append(section)
        viewEntity = chronologicalDate()
        viewController?.updateView(entity: viewEntity)
    }
    
    private func showError(menssage: String) {
        viewController?.showError(menssage: menssage, buttonText: Constants.alertButtonText)
    }
}

