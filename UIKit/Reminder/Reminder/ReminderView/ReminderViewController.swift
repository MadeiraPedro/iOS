//
//  ReminderViewController.swift
//  Reminder
//
//  Created by Pedro Rafael Madeira Vasconcelos on 02/10/23.
//

import Foundation
import UIKit

public class ReminderViewController: UIViewController {
    
    public enum Constants {
        static let controllerTitle = "Lembrete"
    }
    
    private let contentView: ReminderView?
    private let viewModel: ReminderViewModel?
    private var viewEntity: [ReminderViewEntity] = []
    
    init(contentView: ReminderView = ReminderView(),
         viewModel: ReminderViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.controllerTitle
        setup()
    }
    
    private func setup() {
        contentSetup()
    }
    
    private func contentSetup() {
        self.view = contentView
        contentView?.delegate = self
    }
    
    public func updateView(entity: [ReminderViewEntity]?) {
        contentView?.updateView(entity)
    }
    
    public func showError(menssage: String, buttonText: String) {
        let alert = UIAlertController(title: nil, message: menssage, preferredStyle: .alert)
        alert.addAction(.init(title: buttonText, style: .destructive))
        present(alert, animated: true)
    }
    
}

extension ReminderViewController: ReminderViewDelegate {
    public func didTapCreateReminder(date: String?, name: String?, entity: [ReminderViewEntity]?) {
        viewModel?.createReminder(stringDate: date, name: name, entity)
    }
}

