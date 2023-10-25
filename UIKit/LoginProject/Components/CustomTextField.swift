//
//  CustomTextField.swift
//  LoginProject
//
//  Created by Pedro Madeira on 24/10/23.
//

import Foundation
import UIKit

public struct CustomTextFieldEntity {
    public let placeHolder: String
    public let icon: UIImage?
    public let isSecureTextEntry: Bool
}

public protocol CustomTextFieldDelegate: AnyObject {
    func textFieldDidChangeSelection(_ textField: UITextField)
    func textFieldShouldReturn(_ textField: UITextField)
}

public class CustomTextField: UIView {
    
    //MARK: - UI
    
    private lazy var contentView: UIView = {
        let view  = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textFieldIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.tintColor = .systemPurple
        return icon
    }()
    
    public lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .none
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var textFieldLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()
        
    //MARK: - DELEGATE
    
    public weak var delegate: CustomTextFieldDelegate?
    
    //MARK: - INIT

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buildViewHerarchy()
        addConstraint()
    }
    
    private func buildViewHerarchy() {
        addSubview(contentView)
        
        contentView.addSubview(textFieldIcon)
        contentView.addSubview(inputTextField)
        contentView.addSubview(textFieldLine)
    }
    
    //MARK: - CONSTRAINTS
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            inputTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: textFieldIcon.trailingAnchor, constant: Metrics.tiny),
            inputTextField.trailingAnchor.constraint(equalTo: textFieldLine.trailingAnchor, constant: -Metrics.small),
            inputTextField.bottomAnchor.constraint(equalTo: textFieldLine.topAnchor, constant: -Metrics.nano),
            
            textFieldLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textFieldLine.heightAnchor.constraint(equalToConstant: Metrics.pico),
            
            textFieldIcon.leadingAnchor.constraint(equalTo: textFieldLine.leadingAnchor, constant: Metrics.tiny),
            textFieldIcon.bottomAnchor.constraint(equalTo: textFieldLine.bottomAnchor, constant: -Metrics.nano),
            
        ])
    }
    
    //MARK: - UPDATE-VIEW
    
    public func updateView(entity: CustomTextFieldEntity) {
        inputTextField.placeholder = entity.placeHolder
        inputTextField.isSecureTextEntry = entity.isSecureTextEntry
        textFieldIcon.image = entity.icon
        
        layoutIfNeeded()
    }
}

//MARK: - EXTENSION

extension CustomTextField: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.textFieldDidChangeSelection(textField)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(textField)
        return true
    }
}
