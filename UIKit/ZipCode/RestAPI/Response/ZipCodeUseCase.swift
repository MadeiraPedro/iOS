//
//  ZipCodeUseCase.swift
//  ZipCode
//
//  Created by Pedro Madeira on 05/10/23.
//

import Foundation
import RxSwift

public final class ZipCodeUseCase {
    public typealias UseCaseEventType = Result<ZipCodeResponse, URLSessionRequest.ServiceError>
    private let service = URLSessionRequest()

    public func execute(cep: String) -> Observable<Result<ZipCodeResponse, URLSessionRequest.ServiceError>> {
        let observer = ReplaySubject<UseCaseEventType>.create(bufferSize: 1)
        service.get(string: cep, response: ZipCodeResponse.self) { result in
            observer.onNext(result.mapError { error in
                URLSessionRequest.ServiceError.network(error)
            })
        }
        return observer
    }

    public func execute2(cep: String) -> Observable<Result<ZipCodeResponse, URLSessionRequest.ServiceError>> {
        let observer = ReplaySubject<UseCaseEventType>.create(bufferSize: 1)
        service.execute(route: .zipcode(cep: cep), httpMethod: .get, response: ZipCodeResponse.self) { result in
            observer.onNext(result.mapError { error in
                URLSessionRequest.ServiceError.network(error)
            })
        }
        return observer
    }
    
}

