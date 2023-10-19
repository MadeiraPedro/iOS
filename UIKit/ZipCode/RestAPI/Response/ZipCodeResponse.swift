//
//  ZipCodeResponse.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation

public struct ZipCodeResponse: Codable {
    public let district: String
    public let zipcode: String
    public let complement: String
    public let ddd: String
    public let ibge: String
    public let locality: String
    public let publicPlace: String
    public let uf: String
    
    enum CodingKeys: String, CodingKey {
        case district = "bairro"
        case zipcode = "cep"
        case complement = "complemento"
        case ddd
        case ibge
        case locality = "localidade"
        case publicPlace = "logradouro"
        case uf
    }
}

