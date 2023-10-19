//
//  ObservableExtensions.swift
//  ZipCode
//
//  Created by Pedro Madeira on 11/10/23.
//

import Foundation
import RxSwift

extension Observable {
    public func subscribeOnMainDisposed(by disposeBag: DisposeBag, onNext: ((Observable.Element) -> Void)? = nil) {
        subscribe(on: ConcurrentDispatchQueueScheduler(queue: .global(qos: .background)))
        .observe(on: ConcurrentMainScheduler.instance)
        .subscribe(onNext: onNext)
        .disposed(by: disposeBag)
    }
}
