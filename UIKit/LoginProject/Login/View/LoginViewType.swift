//
//  LoginViewType.swift
//  LoginProject
//
//  Created by Pedro Madeira on 18/10/23.
//

import Foundation

public protocol LoginViewType: AnyObject {
    var deleagte: LoginViewDelegate? { get set }
}

public protocol LoginViewDelegate: AnyObject {
//    func didTapCreateReminder(date: String?, name: String?, entity: [ReminderViewEntity]?)
}
