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
        static let screenTitle = "Login"
        static let nameTag = "E-Mail"
        static let dataTag = "Senha"
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
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var screenTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Metrics.large)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextFieldTag: UILabel = {
        let tag = UILabel()
        tag.translatesAutoresizingMaskIntoConstraints = false
        tag.font = .systemFont(ofSize: 16, weight: .semibold)
        tag.backgroundColor = .purple
        tag.textColor = .white
        tag.textAlignment = .center
        tag.setContentHuggingPriority(.required, for: .horizontal)
        return tag
    }()
    
    private lazy var dateTextFieldTag: UILabel = {
        let tag = UILabel()
        tag.translatesAutoresizingMaskIntoConstraints = false
        tag.font = .systemFont(ofSize: 16, weight: .semibold)
        tag.backgroundColor = .purple
        tag.textColor = .white
        tag.textAlignment = .center
        return tag
    }()
    
    private lazy var reminderNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .bezel
        textField.placeholder = Constants.emailPlaceholder
        textField.clearButtonMode = .always
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var reminderDateTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .bezel
        textField.placeholder = Constants.passwordPlaceholder
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.autocapitalizationType = .none
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.loginButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.createAccountButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var reminderName: String?
    private var reminderData: String?
    
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
        
        contentView.addSubview(separator)
        contentView.addSubview(screenTitle)
        contentView.addSubview(nameTextFieldTag)
        contentView.addSubview(dateTextFieldTag)
        contentView.addSubview(reminderNameTextField)
        contentView.addSubview(reminderDateTextField)
        contentView.addSubview(loginButton)
        contentView.addSubview(createAccountButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            separator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.5),
            
            screenTitle.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 56),
            screenTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            screenTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            screenTitle.bottomAnchor.constraint(equalTo: reminderNameTextField.topAnchor, constant: -100),
            
            nameTextFieldTag.topAnchor.constraint(equalTo: reminderNameTextField.topAnchor),
            nameTextFieldTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            nameTextFieldTag.trailingAnchor.constraint(equalTo: reminderNameTextField.leadingAnchor, constant: -Metrics.nano),
            nameTextFieldTag.bottomAnchor.constraint(equalTo: reminderNameTextField.bottomAnchor),
            nameTextFieldTag.widthAnchor.constraint(equalToConstant: Metrics.tagWidth),
            
            reminderNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            reminderNameTextField.bottomAnchor.constraint(equalTo: reminderDateTextField.topAnchor, constant: -Metrics.small),
            
            dateTextFieldTag.topAnchor.constraint(equalTo: reminderDateTextField.topAnchor),
            dateTextFieldTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            dateTextFieldTag.trailingAnchor.constraint(equalTo: reminderDateTextField.leadingAnchor, constant: -Metrics.nano),
            dateTextFieldTag.bottomAnchor.constraint(equalTo: reminderDateTextField.bottomAnchor),
            dateTextFieldTag.widthAnchor.constraint(equalToConstant: Metrics.tagWidth),
            
            reminderDateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            reminderDateTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -Metrics.medium),
            
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -Metrics.small),
            loginButton.widthAnchor.constraint(equalToConstant: 140),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            createAccountButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            loginButton.bottomAnchor.constraint(equalTo: contentReminderList.topAnchor, constant: -Metrics.large),
            createAccountButton.widthAnchor.constraint(equalToConstant: 140),
            createAccountButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    
    //MARK: - Button Action
    
    @objc private func didTapLoginButton() {
        reminderDateTextField.resignFirstResponder()
        reminderNameTextField.resignFirstResponder()
//        delegate?.didTapCreateReminder(date: reminderData, name: reminderName, entity: viewEntity)
    }
    
    @objc private func didTapCreateAccountButton() {
//        reminderDateTextField.resignFirstResponder()
//        reminderNameTextField.resignFirstResponder()
//        delegate?.didTapCreateReminder(date: reminderData, name: reminderName, entity: viewEntity)
    }
    
    //MARK: - UpdateView
    
    private func updateDefaultValues() {
        screenTitle.text = Constants.screenTitle
        nameTextFieldTag.text = Constants.nameTag
        dateTextFieldTag.text = Constants.dataTag
//        reminderListTitle.text = Constants.reminderListTitle
    }
    
    public func updateView() {

    }
}

//MARK: - Extensions

extension LoginView: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == reminderNameTextField {
            reminderName = textField.text
        } else {
            reminderData = textField.text
        }
    }
        
//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == reminderDateTextField {
//            if (reminderDateTextField.text?.count == 2) || (reminderDateTextField.text?.count == 5) {
//                if !(string == "") {
//                    reminderDateTextField.text = (reminderDateTextField.text)! + "/" //validar para só numerosssssss e fazer uma tela de menu
//                }
//            }
//            return !(textField.text!.count > 9 && (string.count ) > range.length)
//        }
//        return true
//    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == reminderNameTextField {
            reminderDateTextField.becomeFirstResponder()
        } else {
            didTapLoginButton() //talves usar operador ternario ao inves de if else
        }
        //se for o outro e dar enter poderia ja chamar a ação do botão
        return true
    }
}
