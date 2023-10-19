//
//  ZipCodeView.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public final class ZipCodeView: UIView {
    
    enum Constants {
        static let title = "Consulta por CEP"
        static let zipcodeTitles = ["CEP: ", "Logradouro: ", "Complemento: ", "Bairro: ", "Localidade: ", "UF: ", "IBGE: ", "DDD: "]
        static let exampleZipcode = "Ex: 30250-100 ou 30250100"
    }
    
    public lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.text = Constants.title
        label.font = .boldSystemFont(ofSize: Metrics.medium)
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = Constants.exampleZipcode
        textField.clearsOnBeginEditing = true
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: Metrics.small)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var textFieldBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var searchIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = .purple
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSearchIcon)))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public lazy var contentZipcodeData: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    public lazy var zipcodeDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = Metrics.small
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.layer.cornerRadius = Metrics.tiny
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var cep: String?
    private var stringData: [String] = []
    
    private var textFieldBarColor: UIColor = .lightGray {
        didSet {
            textFieldBar.backgroundColor = textFieldBarColor
        }
    }
    
    // MARK: - DELEGATE
    
    public weak var delegate: ZipCodeViewDelegate?
    
    // MARK: - INIT
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(contentView)
        contentView.addSubview(separator)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(textFieldBar)
        contentView.addSubview(searchIcon)
        contentView.addSubview(contentZipcodeData)
        contentView.addSubview(backButton)
        
        contentZipcodeData.addSubview(zipcodeDataStackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            separator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.5),

            titleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.medium),
            textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 35),
            
            searchIcon.topAnchor.constraint(equalTo: textField.topAnchor, constant: 6),
            searchIcon.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Metrics.tiny),
            searchIcon.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -6),
            searchIcon.widthAnchor.constraint(equalToConstant: Metrics.medium),
            
            textFieldBar.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            textFieldBar.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textFieldBar.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            textFieldBar.heightAnchor.constraint(equalToConstant: 1.5),
            
            contentZipcodeData.topAnchor.constraint(equalTo: textFieldBar.bottomAnchor, constant: Metrics.large),
            contentZipcodeData.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium),
            contentZipcodeData.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium),
            contentZipcodeData.bottomAnchor.constraint(greaterThanOrEqualTo: backButton.topAnchor, constant: -Metrics.large),
            
            zipcodeDataStackView.topAnchor.constraint(equalTo: contentZipcodeData.topAnchor, constant: Metrics.small),
            zipcodeDataStackView.leadingAnchor.constraint(equalTo: contentZipcodeData.leadingAnchor, constant: Metrics.medium),
            zipcodeDataStackView.trailingAnchor.constraint(equalTo: contentZipcodeData.trailingAnchor, constant: -Metrics.medium),
            zipcodeDataStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentZipcodeData.bottomAnchor, constant: -Metrics.small),
                        
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium),
            backButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium),
            backButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.large),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight)
        ])
    }

    
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    @objc private func didTapSearchIcon() {
        textField.resignFirstResponder()
        if let cep {
            delegate?.didTapSearchIcon(cep: cep)
        }
    }
    
    private func makeLabelAndValue(_ text: String, value: String?) {
        let labelAndValue = LabelAndValueView()
        labelAndValue.translatesAutoresizingMaskIntoConstraints = false
        labelAndValue.updateView(text: text, value: value)
        
        zipcodeDataStackView.addArrangedSubview(labelAndValue)
    }
    
    public func updateView(entity: ZipCodeViewEntity?) {
        zipcodeDataStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let entity {
            stringData.append(entity.zipcode)
            stringData.append(entity.publicPlace)
            stringData.append(entity.complement)
            stringData.append(entity.district)
            stringData.append(entity.locality)
            stringData.append(entity.uf)
            stringData.append(entity.ibge)
            stringData.append(entity.ddd)
            
            for index in 0 ... (stringData.count-1) {
                makeLabelAndValue(Constants.zipcodeTitles[index], value: stringData[index])
            }
            
        } else {
            Constants.zipcodeTitles.forEach {
                makeLabelAndValue($0, value: " ")
            }
        }
        stringData.removeAll()
    }
    
}

extension ZipCodeView: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "")
        cep = textField.text
        textFieldBarColor = .lightGray
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.textField {
            if (self.textField.text?.count == 5){
                if !(string == "") {
                    self.textField.text = (self.textField.text)! + "-"
                }
            }
            return !(textField.text!.count > 8 && (string.count ) > range.length)
        }
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBarColor = .purple
    }
}

