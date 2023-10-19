//
//  ZipCodeViewType.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public protocol ZipCodeViewType: AnyObject {
    var contentView: UIView { get }
    var deleagte: ZipCodeViewDelegate? { get set }
}

public protocol ZipCodeViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapSearchIcon(cep: String)
}

extension ZipCodeViewType where Self: UIView {
    public var contentView: UIView { return self }
}
