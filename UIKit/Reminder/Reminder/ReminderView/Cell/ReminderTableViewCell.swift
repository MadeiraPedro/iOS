//
//  ReminderTableViewCell.swift
//  Reminder
//
//  Created by Pedro Rafael Madeira Vasconcelos on 02/10/23.
//

import Foundation
import UIKit

public class ReminderTableViewCell: UITableViewCell {
    
    public lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var circleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle.fill")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.left")
        image.tintColor = .systemGray2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var trashIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "trash")
        image.tintColor = .systemGray
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        
        view.addSubview(circleIcon)
        view.addSubview(descriptionLabel)
        view.addSubview(arrowIcon)
        view.addSubview(trashIcon)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            circleIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.medium),
            circleIcon.trailingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: -Metrics.tiny),
            circleIcon.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            circleIcon.widthAnchor.constraint(equalToConstant: Metrics.nano),
            circleIcon.heightAnchor.constraint(equalToConstant: Metrics.nano),
            
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.tiny),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Metrics.tiny),
            
            arrowIcon.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: Metrics.pico),
            arrowIcon.trailingAnchor.constraint(equalTo: trashIcon.leadingAnchor, constant: -Metrics.pico),
            arrowIcon.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -Metrics.pico),
            arrowIcon.widthAnchor.constraint(equalToConstant: 11),
            arrowIcon.heightAnchor.constraint(equalToConstant: 15),
            
            trashIcon.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: Metrics.pico),
            trashIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.small),
            trashIcon.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -Metrics.pico),
            trashIcon.widthAnchor.constraint(equalToConstant: 12),
            trashIcon.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    public func updateView(_ title: String) {
        descriptionLabel.text = title
    }
}

