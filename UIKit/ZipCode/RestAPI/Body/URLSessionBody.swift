//
//  URLSessionBody.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public struct URLSessionPostBody: Codable {
    public var zipcode: String
    public var ddd: String
    public var uf: String
   
    public init(zipcode: String, ddd: String, uf: String) {
        self.zipcode = zipcode
        self.ddd = ddd
        self.uf = uf
    }
    
    enum CodingKeys: String, CodingKey {
        case zipcode = "CEP"
        case ddd = "DDD"
        case uf = "UF"
    }
}

public struct URLSessionPutBody: Codable {
    public var firstName: String
    public var lastName: String
    public var email: String
   
    public init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
    }
}

public struct LoginBody: Codable {
    public var email: String
    public var password: String?
    
    init(email: String, password: String?) {
        self.email = email
        self.password = password
    }
}

