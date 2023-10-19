//
//  ViewController.swift
//  LoginProject
//
//  Created by Pedro Madeira on 18/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Tela de Menu
//        goToMenuScreenView()
        
        //MARK: Tela de Login
        goToLoginView()
    }

    func goToMenuScreenView() {
        let viewController = MenuScreenViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToLoginView() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

