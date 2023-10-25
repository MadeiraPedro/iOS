//
//  CreateAccountViewType.swift
//  LoginProject
//
//  Created by Pedro Madeira on 24/10/23.
//

import Foundation

public protocol CreateAccountViewType: AnyObject {
    var deleagte: CreateAccountViewDelegate? { get set }
}

public protocol CreateAccountViewDelegate: AnyObject {
    func didTapCreateAccount(_ username: String?, _ email: String?, _ password: String?, _ confirmPassword: String?)
}
