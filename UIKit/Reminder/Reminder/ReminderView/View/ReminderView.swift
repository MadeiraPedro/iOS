//
//  ReminderView.swift
//  Reminder
//
//  Created by Pedro Rafael Madeira Vasconcelos on 02/10/23.
//

import Foundation
import UIKit

public class ReminderView: UIView {
    
    public enum Constants {
        static let cellIdentifier = "reminderTableViewCell"
        static let headerIdentifier = "reminderTableViewHeader"
        
        static let reminderNamePlaceholder = "Ex: Ir ao médico"
        static let reminderDatePlaceholder = "Ex: 03/10/2023"
        static let screenTitle = "Novo lembrete"
        static let nameTag = "Nome"
        static let dataTag = "Data"
        static let reminderListTitle = "Lista de lembretes"
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
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextFieldTag: UILabel = {
        let tag = UILabel()
        tag.translatesAutoresizingMaskIntoConstraints = false
        tag.font = .systemFont(ofSize: 16, weight: .semibold)
        tag.backgroundColor = .purple
        tag.textColor = .white
        tag.textAlignment = .center
        tag.setContentHuggingPriority(.required, for: .horizontal)
        return tag
    }()
    
    private lazy var dateTextFieldTag: UILabel = {
        let tag = UILabel()
        tag.translatesAutoresizingMaskIntoConstraints = false
        tag.font = .systemFont(ofSize: 16, weight: .semibold)
        tag.backgroundColor = .purple
        tag.textColor = .white
        tag.textAlignment = .center
        return tag
    }()
    
    private lazy var reminderNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .bezel
        textField.placeholder = Constants.reminderNamePlaceholder
        textField.clearButtonMode = .always
        textField.textContentType = .emailAddress
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var reminderDateTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .bezel
        textField.placeholder = Constants.reminderDatePlaceholder
        textField.clearButtonMode = .always
        textField.keyboardType = .numberPad
        textField.textContentType = .dateTime
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var createReminderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var reminderListTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24.0)
        label.textAlignment = .left
        label.textColor = .systemGray5
        return label
    }()
    
    private lazy var reminderListTitleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "pencil.line")
        image.tintColor = .gray
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var contentReminderList: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.register(ReminderTableViewHeader.self, forHeaderFooterViewReuseIdentifier: Constants.headerIdentifier)
        tableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var viewEntity: [ReminderViewEntity] = []
    private var reminderName: String?
    private var reminderData: String?
    
    // MARK: - DELEGATE
    
    public weak var delegate: ReminderViewDelegate?
    
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
        contentView.addSubview(screenTitle)
        contentView.addSubview(nameTextFieldTag)
        contentView.addSubview(dateTextFieldTag)
        contentView.addSubview(reminderNameTextField)
        contentView.addSubview(reminderDateTextField)
        contentView.addSubview(createReminderButton)
        contentView.addSubview(contentReminderList)
        
        contentReminderList.addSubview(reminderListTitle)
        contentReminderList.addSubview(reminderListTitleIcon)
        contentReminderList.addSubview(tableView)
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
            
            screenTitle.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 56),
            screenTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            screenTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            screenTitle.bottomAnchor.constraint(equalTo: reminderNameTextField.topAnchor, constant: -100),
            
            nameTextFieldTag.topAnchor.constraint(equalTo: reminderNameTextField.topAnchor),
            nameTextFieldTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            nameTextFieldTag.trailingAnchor.constraint(equalTo: reminderNameTextField.leadingAnchor, constant: -Metrics.nano),
            nameTextFieldTag.bottomAnchor.constraint(equalTo: reminderNameTextField.bottomAnchor),
            nameTextFieldTag.widthAnchor.constraint(equalToConstant: Metrics.tagWidth),
            
            reminderNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            reminderNameTextField.bottomAnchor.constraint(equalTo: reminderDateTextField.topAnchor, constant: -Metrics.small),
            
            dateTextFieldTag.topAnchor.constraint(equalTo: reminderDateTextField.topAnchor),
            dateTextFieldTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            dateTextFieldTag.trailingAnchor.constraint(equalTo: reminderDateTextField.leadingAnchor, constant: -Metrics.nano),
            dateTextFieldTag.bottomAnchor.constraint(equalTo: reminderDateTextField.bottomAnchor),
            dateTextFieldTag.widthAnchor.constraint(equalToConstant: Metrics.tagWidth),
            
            reminderDateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
            reminderDateTextField.bottomAnchor.constraint(equalTo: createReminderButton.topAnchor, constant: -Metrics.medium),
            
            createReminderButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createReminderButton.bottomAnchor.constraint(equalTo: contentReminderList.topAnchor, constant: -Metrics.large),
            createReminderButton.widthAnchor.constraint(equalToConstant: 60),
            createReminderButton.heightAnchor.constraint(equalToConstant: 45),
            
            contentReminderList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentReminderList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentReminderList.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.medium),
            
            reminderListTitle.topAnchor.constraint(equalTo: contentReminderList.topAnchor),
            reminderListTitle.leadingAnchor.constraint(equalTo: contentReminderList.leadingAnchor, constant: Metrics.small),
            reminderListTitle.trailingAnchor.constraint(equalTo: reminderListTitleIcon.leadingAnchor, constant: -Metrics.small),
            reminderListTitle.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -Metrics.small),
            
            reminderListTitleIcon.topAnchor.constraint(equalTo: reminderListTitle.topAnchor),
            reminderListTitleIcon.bottomAnchor.constraint(equalTo: reminderListTitle.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: contentReminderList.leadingAnchor, constant: Metrics.small),
            tableView.trailingAnchor.constraint(equalTo: contentReminderList.trailingAnchor, constant: -Metrics.small),
            tableView.bottomAnchor.constraint(equalTo: contentReminderList.bottomAnchor)
        ])
    }

    
    //MARK: - Button Action
    
    @objc private func didTapCreateButton() {
        reminderDateTextField.resignFirstResponder()
        reminderNameTextField.resignFirstResponder()
        delegate?.didTapCreateReminder(date: reminderData, name: reminderName, entity: viewEntity)
    }
    
    //MARK: - UpdateView
    
    private func updateDefaultValues() {
        screenTitle.text = Constants.screenTitle
        nameTextFieldTag.text = Constants.nameTag
        dateTextFieldTag.text = Constants.dataTag
        reminderListTitle.text = Constants.reminderListTitle
    }
    
    public func updateView(_ entity: [ReminderViewEntity]?) {
        guard let entity else {
            contentReminderList.isHidden = true
            return
        }
        viewEntity = entity
        tableView.reloadData()
        contentReminderList.isHidden = false

    }
}

//MARK: - Extensions

extension ReminderView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewEntity[section].cellRows?.count ?? .zero
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewEntity.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerIdentifier) as? ReminderTableViewHeader else {
            return nil
        }
        header.updateView(viewEntity[section].sectionTitle)
        return header
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ReminderTableViewCell else {
            return UITableViewCell()
        }
        cell.updateView(viewEntity[indexPath.section].cellRows?[indexPath.row] ?? "")
        return cell
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            viewEntity[indexPath.section].cellRows?.remove(at: indexPath.row)
            if viewEntity[indexPath.section].cellRows?.count == .zero {
                viewEntity.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .none)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
        }
    }
}

extension ReminderView: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == reminderNameTextField {
            reminderName = textField.text
        } else {
            reminderData = textField.text
        }
    }
        
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == reminderDateTextField {
            if (reminderDateTextField.text?.count == 2) || (reminderDateTextField.text?.count == 5) {
                if !(string == "") {
                    reminderDateTextField.text = (reminderDateTextField.text)! + "/" //validar para só numerosssssss e fazer uma tela de menu
                }
            }
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == reminderNameTextField {
            reminderDateTextField.becomeFirstResponder()
        }
        return true
    }
}
