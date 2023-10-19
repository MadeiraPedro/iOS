//
//  ReminderTableViewHeader.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public class ReminderTableViewHeader: UITableViewHeaderFooterView {
    
    private enum Constants {
        static let dateFormat = "dd/MM/yyyy"
    }
    
    public lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 18)
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
    
    private lazy var calendarIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .systemGray
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
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
        
        view.addSubview(dataLabel)
        view.addSubview(calendarIcon)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dataLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.nano),
            dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.tiny),
            dataLabel.trailingAnchor.constraint(equalTo: calendarIcon.leadingAnchor, constant: -Metrics.tiny),
            dataLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Metrics.nano),
            
            
            calendarIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.pico),
            calendarIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Metrics.pico),
        ])
    }
    
    public func updateView(_ date: Date?) {
        guard let date else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        dataLabel.text = formatter.string(from: date)
    }
}

