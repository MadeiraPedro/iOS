//
//  MenuScreenViewController.swift
//  Reminder
//
//  Created by Pedro Madeira on 04/10/23.
//

import Foundation
import UIKit

public class MenuScreenViewController: UIViewController {
    
    public enum Constants {
        static let controllerTitle = "Menu"
    }
    
    private let contentView: MenuScreenView?
    
    init(contentView: MenuScreenView = MenuScreenView()) {
        self.contentView = contentView
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
    
    private func navigation(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MenuScreenViewController: MenuScreenViewDelegate {
    public func didTapRestAPIButton() {
        let viewModel = ZipCodeViewModel()
        let viewController = ZipCodeViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        navigation(viewController: viewController)
    }
}

