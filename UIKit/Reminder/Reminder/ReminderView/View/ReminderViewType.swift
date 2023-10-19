//
//  ReminderViewType.swift
//  Reminder
//
//  Created by Pedro Rafael Madeira Vasconcelos on 02/10/23.
//

import Foundation

public protocol ReminderViewType: AnyObject {
    var deleagte: ReminderViewDelegate? { get set }
}

public protocol ReminderViewDelegate: AnyObject {
    func didTapCreateReminder(date: String?, name: String?, entity: [ReminderViewEntity]?)
}

