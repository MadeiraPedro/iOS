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

    //MARK: - INIT
    
    init(contentView: LoginView = LoginView(),
         viewModel: LoginViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        //fazer um login ou shimmer
    }
    
    public override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true)
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

extension LoginViewController: LoginViewDelegate {
    public func didTapLogin(email: String?, password: String?) {
        viewModel?.validadeLogin(email: email, password: password)
    }
    
    public func didTapCreateAccount() {
        let viewModel = CreateAccountViewModel()
        let viewController = CreateAccountViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        navigation(controller: viewController)
    }
}

