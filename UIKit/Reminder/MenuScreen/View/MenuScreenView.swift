//
//  MenuScreenView.swift
//  Reminder
//
//  Created by Pedro Madeira on 04/10/23.
//

import Foundation
import UIKit

public class MenuScreenView: UIView {
    
    public enum Constants {
        static let screenTitle = "Selecione alguma das opções:"
        static let restAPIButtonTitle = " RestAPI"
        static let reminderButtonTitle = " Lembrete"
    }
    
    //MARK: - UI
    
    private lazy var contentView: UIView = {
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
    
    private lazy var screenTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Metrics.large)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Metrics.medium
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var reminderButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.reminderButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.setImage(UIImage(systemName: "note.text"), for: .normal)
        button.addTarget(self, action: #selector(didTapReminderButton), for: .touchUpInside)
        button.layer.cornerRadius = Metrics.tiny
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var RestAPIButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.restAPIButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.setImage(UIImage(systemName: "network"), for: .normal)
        button.addTarget(self, action: #selector(didTapRestAPIButton), for: .touchUpInside)
        button.layer.cornerRadius = Metrics.tiny
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - DELEGATE
    
    public weak var delegate: MenuScreenViewDelegate?
    
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
        updateDefaultValues()
    }
    
    //MARK: - Constraints
    
    private func buildViewHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(separator)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(screenTitle)
        stackView.addArrangedSubview(reminderButton)
        stackView.addArrangedSubview(RestAPIButton)
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
            
            stackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: Metrics.large),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.large),
            
            RestAPIButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight),
            RestAPIButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidht),
            
            reminderButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight),
            reminderButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidht),
        ])
    }

    
    //MARK: - Button Action
    
    @objc private func didTapRestAPIButton() {
        delegate?.didTapRestAPIButton()
    }
    
    @objc private func didTapReminderButton() {
        delegate?.didTapReminderButton()
    }
    
    //MARK: - UpdateView
    
    private func updateDefaultValues() {
        screenTitle.text = Constants.screenTitle

    }
}
