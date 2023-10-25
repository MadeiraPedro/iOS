//
//  CreateAccountView.swift
//  LoginProject
//
//  Created by Pedro Madeira on 24/10/23.
//

import Foundation
import UIKit

public class CreateAccountView: UIView {
    
    public enum Constants {
        static let createAccountButtonTitle = "Criar contra"
    }
    
    //MARK: - UI
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var screenLogo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "icon"))
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var usernameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmPasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.createAccountButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var usernameText: String? = nil
    private var emailText: String? = nil
    private var passwordText: String? = nil
    private var confirmPasswordText: String? = nil
    
    // MARK: - DELEGATE
    
    public weak var delegate: CreateAccountViewDelegate?
    
    // MARK: - INIT
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        buildViewHierarchy()
        addConstraints()
        updateDefaultValues()
    }
    
    //MARK: - Constraints
    
    private func buildViewHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(screenLogo)
        
        contentView.addSubview(usernameTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(confirmPasswordTextField)
        
        contentView.addSubview(createAccountButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            screenLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150),
            screenLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            screenLogo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            screenLogo.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -100),
            screenLogo.heightAnchor.constraint(equalToConstant: 65),
            screenLogo.widthAnchor.constraint(equalToConstant: 65),
            
            usernameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.big),
            usernameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.big),
            usernameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -Metrics.medium),
            
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.big),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.big),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -Metrics.medium),
            
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.big),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.big),
            passwordTextField.bottomAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: -Metrics.medium),
            
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.big),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.big),
            confirmPasswordTextField.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -Metrics.extra),
            
            createAccountButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalToConstant: 120),
            createAccountButton.heightAnchor.constraint(equalToConstant: 40),

        ])
    }

    
    //MARK: - Button Action
    
    @objc private func didTapCreateAccountButton() { //TODO: talvez melhorar esse delegate enviando uma entity
        delegate?.didTapCreateAccount(usernameText, emailText, passwordText, confirmPasswordText)
    }
    
    //MARK: - UpdateView
    
    private func updateDefaultValues() {
        
        //receber um array de entity
        
        let usernameTextFieldEntity = CustomTextFieldEntity(placeHolder: "Usuário",
                                                         icon: UIImage(systemName: "person.fill"),
                                                         isSecureTextEntry: false)
        
        let emailTextFieldEntity = CustomTextFieldEntity(placeHolder: "E-mail",
                                                         icon: UIImage(systemName: "envelope.fill"),
                                                         isSecureTextEntry: false)
        
        let passwordTextFieldEntity = CustomTextFieldEntity(placeHolder: "Senha",
                                                         icon: UIImage(systemName: "lock.fill"),
                                                         isSecureTextEntry: true) //TODO: Colocar botão para exibir senha
        
        let confirmPasswordTextFieldEntity = CustomTextFieldEntity(placeHolder: "Repetir senha",
                                                         icon: UIImage(systemName: "lock.fill"),
                                                         isSecureTextEntry: true) //TODO: Colocar botão para exibir senha
        
        //TODO: montar a entity numa factory e enviar da model pra view
        
        usernameTextField.updateView(entity: usernameTextFieldEntity)
        emailTextField.updateView(entity: emailTextFieldEntity)
        passwordTextField.updateView(entity: passwordTextFieldEntity)
        confirmPasswordTextField.updateView(entity: confirmPasswordTextFieldEntity)
    }
    
    public func updateView() {

    }
}

//MARK: - Extensions

extension CreateAccountView: CustomTextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == usernameTextField.inputTextField {
            usernameText = textField.text
        } else if textField == emailTextField.inputTextField {
            emailText = textField.text
        } else if textField == passwordTextField.inputTextField {
            passwordText = textField.text
        } else {
            confirmPasswordText = textField.text
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) {
        if textField == usernameTextField.inputTextField {
            emailTextField.inputTextField.becomeFirstResponder()
        } else if textField == emailTextField.inputTextField {
            passwordTextField.inputTextField.becomeFirstResponder()
        } else if textField == passwordTextField.inputTextField {
            confirmPasswordTextField.inputTextField.becomeFirstResponder()
        } else {
            confirmPasswordTextField.inputTextField.resignFirstResponder()
        }
    }
}
