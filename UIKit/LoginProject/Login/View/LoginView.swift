//
//  LoginView.swift
//  LoginProject
//
//  Created by Pedro Madeira on 18/10/23.
//

import Foundation
import UIKit

public class LoginView: UIView {
    
    public enum Constants {
        static let emailPlaceholder = "E-mail"
        static let passwordPlaceholder = "Senha"
        static let loginButtonTitle = "Entrar"
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
    
    private lazy var emailIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "envelope.fill"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.tintColor = .systemPurple
        return icon
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .none
        textField.placeholder = Constants.emailPlaceholder
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailTextFieldLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()
    
    private lazy var passwordIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "lock.fill"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.tintColor = .systemPurple
        return icon
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .none
        textField.placeholder = Constants.passwordPlaceholder
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.autocapitalizationType = .none
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextFieldLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.loginButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.createAccountButtonTitle, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var emailText: String? = nil
    private var passwordText: String? = nil
    
    // MARK: - DELEGATE
    
    public weak var delegate: LoginViewDelegate?
    
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

        contentView.addSubview(emailIcon)
        contentView.addSubview(emailTextField)
        contentView.addSubview(emailTextFieldLine)
        
        contentView.addSubview(passwordIcon)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(passwordTextFieldLine)
        
        contentView.addSubview(loginButton)
        contentView.addSubview(createAccountButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            screenLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 180),
            screenLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            screenLogo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            screenLogo.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -100),
            screenLogo.heightAnchor.constraint(equalToConstant: 80),
            screenLogo.widthAnchor.constraint(equalToConstant: 80),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: Metrics.tiny),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldLine.trailingAnchor, constant: -Metrics.small),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldLine.topAnchor, constant: -Metrics.nano),
            
            emailTextFieldLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.big),
            emailTextFieldLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.big),
            emailTextFieldLine.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -Metrics.medium),
            emailTextFieldLine.heightAnchor.constraint(equalToConstant: Metrics.pico),
            
            emailIcon.leadingAnchor.constraint(equalTo: emailTextFieldLine.leadingAnchor, constant: Metrics.tiny),
            emailIcon.bottomAnchor.constraint(equalTo: emailTextFieldLine.bottomAnchor, constant: -Metrics.nano),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordIcon.trailingAnchor, constant: Metrics.tiny),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldLine.trailingAnchor, constant: -Metrics.small),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldLine.topAnchor, constant: -Metrics.nano),
            
            passwordTextFieldLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.big),
            passwordTextFieldLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.big),
            passwordTextFieldLine.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -Metrics.large),
            passwordTextFieldLine.heightAnchor.constraint(equalToConstant: Metrics.pico),
            
            passwordIcon.leadingAnchor.constraint(equalTo: passwordTextFieldLine.leadingAnchor, constant: Metrics.tiny),
            passwordIcon.bottomAnchor.constraint(equalTo: passwordTextFieldLine.bottomAnchor, constant: -Metrics.nano),

            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -Metrics.small),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 40),

            createAccountButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    
    //MARK: - Button Action
    
    @objc private func didTapLoginButton() {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        delegate?.didTapLogin(email: emailText, password: passwordText)
    }
    
    @objc private func didTapCreateAccountButton() {
        delegate?.didTapCreateAccount()
    }
    
    //MARK: - UpdateView
    
    private func updateDefaultValues() {
        
    }
    
    public func updateView() {

    }
}

//MARK: - Extensions

extension LoginView: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == emailTextField {
            emailText = textField.text
        } else {
            passwordText = textField.text
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            didTapLoginButton() //TODO: talves usar operador ternario ao inves de if else
        }
        return true
    }
}
