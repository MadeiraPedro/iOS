//
//  LoginViewController.swift
//  LoginProject
//
//  Created by Pedro Madeira on 18/10/23.
//

import Foundation
import UIKit

public class LoginViewController: UIViewController {
    
    public enum Constants {
        static let controllerTitle = "Login"
    }
    
    private let contentView: LoginView?
    private let viewModel: LoginViewModel?
//    private var viewEntity: [ReminderViewEntity] = []
    
    init(contentView: LoginView = LoginView(),
         viewModel: LoginViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true)
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
    
    public func updateView() {
        contentView?.updateView()
    }
    
    public func showError(menssage: String, buttonText: String) {
        let alert = UIAlertController(title: nil, message: menssage, preferredStyle: .alert)
        alert.addAction(.init(title: buttonText, style: .destructive))
        present(alert, animated: true)
    }
    
}

extension LoginViewController: LoginViewDelegate {
//    public func didTapCreateReminder(date: String?, name: String?, entity: [ReminderViewEntity]?) {
//        viewModel?.createReminder(stringDate: date, name: name, entity)
//    }
}

