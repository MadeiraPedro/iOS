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
    }

    func goToMenuScreenView() {
        let viewController = MenuScreenViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

