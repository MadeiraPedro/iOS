//
//  CreateAccountViewModel.swift
//  LoginProject
//
//  Created by Pedro Madeira on 24/10/23.
//

import Foundation
import UIKit
import Firebase


public class CreateAccountViewModel {
    
    private enum Metrics {
        static let minimumPasswordSize = 8
    }
    
    private enum Constants {
        static let alertButtonText = "Entendi"
        static let alertMenssage = "Ops, Tivemos um erro! \nVerifique se todos os campos foram preenchidos corretamente"
        static let alertInvalidPasswordLength = "Ops, Tivemos um erro! \nA senha inserida deve conter pelo menos 8 caracteres."
        static let alertInvalidPasswords = "Ops, Tivemos um erro! \nVerifique se as senhas inseridas são iguais."
        static let alertInvalidEmail = "Ops, Tivemos um erro! \nVerifique o campo e-mail foi digitado corretamente"

        static let emailRules = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    public weak var viewController: CreateAccountViewController?
    private var auth: Auth? = .auth()
          
    
    public func createAccount(username: String?, email: String?, password: String?, confirmPassword: String?) {
        guard let username, let email, let password, let confirmPassword else {
            showError(menssage: Constants.alertMenssage)
            return
        }
        
        if isValidEmail(email) && isValidPassword(password: password, confirmPassword: confirmPassword) {
            executeCreateAccount(email: email, password: password)
        }
    }
    
    //MARK: - VALIDATION
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", Constants.emailRules)
        
        if !emailPred.evaluate(with: email) {
            showError(menssage: Constants.alertInvalidEmail)
        }
        
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(password: String, confirmPassword: String) -> Bool {
        guard password.count >= Metrics.minimumPasswordSize else {
            showError(menssage: Constants.alertInvalidPasswordLength)
            return false
        }
        
        if !password.elementsEqual(confirmPassword) {
            showError(menssage: Constants.alertInvalidPasswords)
        }
        
        return password.elementsEqual(confirmPassword)
    }
    
    //MARK: - EXECUTE AUTH
    
    private func executeCreateAccount(email: String, password: String) { //TODO: tratar erro quando a conta ja existe
        auth?.createUser(withEmail: email, password: password, completion: { (response, error) in
            if error != nil {
                print("Failed to create account")
            } else {
                print("ACCOUNT CREATED SUCCESSFULLY")
                self.viewController?.goToMenuScreenView()
            }
        })
    }
    
    private func showError(menssage: String) {
        viewController?.showError(menssage: menssage, buttonText: Constants.alertButtonText)
    }
}

