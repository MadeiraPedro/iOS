//
//  MenuScreenViewController.swift
//  LoginProject
//
//  Created by Pedro Madeira on 18/10/23.
//

import Foundation
import UIKit

public class MenuScreenViewController: UIViewController {
    
    public enum Constants {
        static let controllerTitle = "Menu"
    }
    
    private let contentView: MenuScreenView?
    
    //MARK: - INIT
    
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
    
    //MARK: - PRIVATE FUNC
    
    private func setup() {
        contentSetup()
    }
    
    private func contentSetup() {
        self.view = contentView
        contentView?.delegate = self
    }
    
    private func navigation(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - EXTENSION

extension MenuScreenViewController: MenuScreenViewDelegate {
    public func didTapFirstButton() {
        
    }
    
    public func didTapSecondaryButton() {
        
    }
}

