//
//  URLSessionRequestRoute.swift
//  ZipCode
//
//  Created by Pedro Madeira on 16/10/23.
//

import Foundation

public enum URLSessionRequestRoute: Hashable {
    case zipcode(cep: String)
    case post
    
    var path: String {
        switch self {
        case let .zipcode(cep): return "https://viacep.com.br/ws/\(cep)/json"
        case .post: return "https://jsonplaceholder.typicode.com/posts"
        }
    }
}
