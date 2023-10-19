//
//  ViewController.swift
//  Reminder
//
//  Created by Pedro Madeira on 02/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Tela de Menu
        goToMenuScreenView()
        
        //MARK: Tela criada para mostrar exemplos (praticos) de consumo de uma API
//        goToZipCodeView()
    }

    func goToMenuScreenView() {
        let viewController = MenuScreenViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
//    func goToReminderView() {
//        let viewModel = ReminderViewModel()
//        let viewController = ReminderViewController(viewModel: viewModel)
//        viewModel.viewController = viewController
//        navigationController?.pushViewController(viewController, animated: false)
//    }
//    
//    func goToZipCodeView() {
//        let viewModel = ZipCodeViewModel()
//        let viewController = ZipCodeViewController(viewModel: viewModel)
//        viewModel.viewController = viewController
//        navigationController?.pushViewController(viewController, animated: true)
//    }
}

