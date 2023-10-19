//
//  LabelAndValueView.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public class LabelAndValueView: UIView {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var footerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

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
    
    // MARK: - PRIVATE FUNC
    
    private func buildViewHierarchy() {
        addSubview(textLabel)
        addSubview(valueLabel)
        addSubview(footerLine)
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 4),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            footerLine.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 2),
            footerLine.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 2),
            footerLine.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: -2),
            footerLine.heightAnchor.constraint(equalToConstant: 1.5),
        ])
    }

    // MARK: - PUBLIC FUNC

    public func updateView(text: String, value: String?) {
        textLabel.text = text
        valueLabel.text = value
    }
}


