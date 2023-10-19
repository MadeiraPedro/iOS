//
//  ZipCodeViewModel.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public class ZipCodeViewModel {
    
    private var responseData: ZipCodeResponse?
    private var request = URLSessionRequest()
    private var viewEntity: ZipCodeViewEntity?
    public weak var viewController: ZipCodeViewController?
    public typealias UseCaseEventType = Result<ZipCodeResponse, URLSessionRequest.ServiceError>
            
    public func execute(cep: String) {
        executeRequest(cep: cep)
    }
    
    private func executeRequest(cep: String) {
        request.get(string: cep, response: ZipCodeResponse.self) { result in
            DispatchQueue.main.async {
                self.handleZipCode(result)
            }
        }
    }
    
    public func executePost() {
        guard let body = makeRequestBody() else { return }
        request.post(body)
    }
    
    private func handleZipCode(_ result: UseCaseEventType) {
        switch result {
        case let .success(data):
            viewEntity = makeEntity(data)
            viewController?.updateView(viewEntity)
        case let .failure(error):
            print(error)
        }
    }
    
    private func makeEntity(_ data: ZipCodeResponse) -> ZipCodeViewEntity? {
        return ZipCodeViewEntity(district: data.district,
                                    zipcode: data.zipcode,
                                    complement: data.complement,
                                    ddd: data.ddd,
                                    ibge: data.ibge,
                                    locality: data.locality,
                                    publicPlace: data.publicPlace,
                                    uf: data.uf)
    }
    
    private func makeRequestBody() -> URLSessionPostBody? {
        guard let viewEntity else { return nil }
        return URLSessionPostBody(zipcode: viewEntity.zipcode,
                                     ddd: viewEntity.ddd,
                                     uf: viewEntity.uf)
    }
}

