//
//  MenuScreenViewType.swift
//  LoginProject
//
//  Created by Pedro Madeira on 18/10/23.
//

import Foundation

public protocol MenuScreenViewType: AnyObject {
    var deleagte: MenuScreenViewDelegate? { get set }
}

public protocol MenuScreenViewDelegate: AnyObject {
    func didTapFirstButton()
    func didTapSecondaryButton()
}
