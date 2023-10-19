//
//  ZipCodeViewController.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public final class ZipCodeViewController: UIViewController {
    
    private let contentView: ZipCodeView?
    private let viewModel: ZipCodeViewModel?
    
    init(contentView: ZipCodeView = ZipCodeView(),
         viewModel: ZipCodeViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Consulta CEP"
        setup()
    }
    
    private func setup() {
        contentSetup()
    }
    
    private func contentSetup() {
        self.view = contentView
        contentView?.delegate = self
    }
    
    public func updateView(_ entity: ZipCodeViewEntity?) {
        guard let entity else { return }
        
        contentView?.updateView(entity: entity)
        viewModel?.executePost()
    }
    
    public func showError(menssage: String, buttonText: String) {
        let alert = UIAlertController(title: nil, message: menssage, preferredStyle: .alert)
        alert.addAction(.init(title: buttonText, style: .destructive))
        present(alert, animated: true)
    }
}

extension ZipCodeViewController: ZipCodeViewDelegate {
    public func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    public func didTapSearchIcon(cep: String?) {
        viewModel?.execute(cep: cep)
    }
}

