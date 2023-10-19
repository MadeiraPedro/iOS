//
//  MenuScreenViewType.swift
//  Reminder
//
//  Created by Pedro Madeira on 04/10/23.
//

import Foundation

public protocol MenuScreenViewType: AnyObject {
    var deleagte: MenuScreenViewDelegate? { get set }
}

public protocol MenuScreenViewDelegate: AnyObject {
    func didTapRestAPIButton()
    func didTapReminderButton()
}
