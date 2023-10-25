//
//  CreateAccountViewController.swift
//  LoginProject
//
//  Created by Pedro Madeira on 24/10/23.
//

import Foundation
import UIKit

public final class CreateAccountViewController: UIViewController {
    
    public enum Constants {
        static let controllerTitle = "Nova conta"
    }
    
    private let contentView: CreateAccountView?
    private let viewModel: CreateAccountViewModel?
    
    //MARK: - INIT
    
    init(contentView: CreateAccountView = CreateAccountView(),
         viewModel: CreateAccountViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        //TODO: fazer um login ou shimmer
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.controllerTitle
        setup()
    }
    
    //MARK: - PRIVATE FUNC
    
    private func setup() {
        contentSetup()
    }
    
    private func contentSetup() {
        self.view = contentView
        contentView?.delegate = self
    }
    
    private func navigation(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - PUBLIC FUNC
    
    public func updateView() {
        contentView?.updateView()
    }
    
    public func showError(menssage: String, buttonText: String) {
        let alert = UIAlertController(title: nil, message: menssage, preferredStyle: .alert)
        alert.addAction(.init(title: buttonText, style: .destructive))
        present(alert, animated: true)
    }
    
    public func goToMenuScreenView() {
        let menuScreenViewController = MenuScreenViewController()
        navigation(controller: menuScreenViewController)
    }
}

//MARK: - EXTENSION

extension CreateAccountViewController: CreateAccountViewDelegate {
    public func didTapCreateAccount(_ username: String?, _ email: String?, _ password: String?, _ confirmPassword: String?) {
        viewModel?.createAccount(username: username, email: email, password: password, confirmPassword: confirmPassword)
    }
}

