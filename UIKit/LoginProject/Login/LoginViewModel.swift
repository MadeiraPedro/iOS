//
//  LoginViewModel.swift
//  LoginProject
//
//  Created by Pedro Madeira on 18/10/23.
//

import Foundation
import UIKit
import Firebase


public class LoginViewModel {
    
    private enum Metrics {
        static let minimumPasswordSize = 8
    }
    
    private enum Constants {
        static let alertButtonText = "Entendi"
        static let alertMenssage = "Ops, Tivemos um erro! \nVerifique se todos os campos foram preenchidos corretamente"
        static let alertInvalidPasswordLength = "Ops, Tivemos um erro! \nA senha inserida deve conter pelo menos 8 caracteres."
        static let alertInvalidEmail = "Ops, Tivemos um erro! \nVerifique o campo e-mail foi digitado corretamente"

        static let emailRules = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    public weak var viewController: LoginViewController?
    private var auth: Auth? = .auth()
          
    //MARK: - VALIDATION
    
    public func validadeLogin(email: String?, password: String?) {
        guard let email, let password else {
            showError(menssage: Constants.alertMenssage)
            return
        }
        if isValidEmail(email) && isValidPassword(password: password) {
            executeLogin(email: email, password: password)
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", Constants.emailRules)
        
        if !emailPred.evaluate(with: email) {
            showError(menssage: Constants.alertInvalidEmail)
        }
        
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(password: String) -> Bool {
        guard password.count >= Metrics.minimumPasswordSize else {
            showError(menssage: Constants.alertInvalidPasswordLength)
            return false
        }
        return true
    }
    
    //MARK: - EXECUTE AUTH
    
    private func executeLogin(email: String, password: String) { //TODO: tratar erro quando a conta ja existe
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print("LOGIN ERROR")
            } else {
                if user == nil {
                    print("Usuario invalido")
                } else {
                    print("LOGIN SUCCESSFULLY")
                    self.viewController?.goToMenuScreenView()
                }
            }
            
        })
    }
    
    private func showError(menssage: String) {
        viewController?.showError(menssage: menssage, buttonText: Constants.alertButtonText)
    }
}

