//
//  ZipCodeViewModel.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit
import RxSwift

public class ZipCodeViewModel {
    
    private enum Constants {
        static let errorRequest = "Ops, Ocorreu um erro. \nVerifique se os CEP foi digiado corretamente."
        static let errorWithoutZipCode = "Ops, Ocorreu um erro. \nVoce precisa digitar um CEP valido para fazer a consulta"
        static let errorButtonTitle = "Entendi"
    }
    
    private var responseData: ZipCodeResponse?
    private var request = URLSessionRequest()
    private var viewEntity: ZipCodeViewEntity?
    private let zipCodeUseCase = ZipCodeUseCase()
    private let disposeBag = DisposeBag()
    public weak var viewController: ZipCodeViewController?
    public typealias UseCaseEventType = Result<ZipCodeResponse, URLSessionRequest.ServiceError>
            
    public func execute(cep: String?) {
        guard let cep else {
            showError(menssage: Constants.errorWithoutZipCode)
            return
        }
//        executeRequest(cep: cep) //TODO: Request sem RxSwift
        executeRxSwift(cep: cep) //TODO: Request com RxSwift
    }
    
//    private func executeRequest(cep: String) {
//        request.get(string: cep, response: ZipCodeResponse.self) { result in
//            DispatchQueue.main.async {
//                self.handleZipCode(result)
//            }
//        }
//    }
        
    public func executePost() {
        guard let body = makeRequestBody() else { return }
        request.post(body)
    }
    
    public func executeRxSwift(cep: String) {
//        Observable.of("A", "B", "C", "D").subscribe { event in
//            /// Aqui ele imprimirá todos os elementos da sequência
//            print(event.element ?? "")
//        }.disposed(by: disposeBag) /// Aqui ele é desalocado

//        Observable.of(zipCodeUseCase.execute(cep: cep)).subscribe { event in
//            event.element?.subscribe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .background)))
//                .observe(on: ConcurrentMainScheduler.instance)
//                .subscribe { [weak self] in
//                    self?.handleZipCode($0.element!)
//                }
//        }.disposed(by: disposeBag) /// Aqui ele é desalocado
//
        zipCodeUseCase.execute(cep: cep).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleZipCode($0)
        }
    }
    
    private func handleZipCode(_ result: UseCaseEventType) {
        switch result {
        case let .success(data):
            viewEntity = makeEntity(data)
            viewController?.updateView(viewEntity)
        case let .failure(error):
            showError(menssage: Constants.errorRequest)
            print(error)
        }
    }
    
    private func showError(menssage: String) {
        viewController?.showError(menssage: menssage, buttonText: Constants.errorButtonTitle)
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

