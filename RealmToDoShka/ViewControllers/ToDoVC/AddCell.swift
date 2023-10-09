//
//  AddTaskButton.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 03.10.2023.
//

import UIKit

protocol AddTableViewCellDelegate: AnyObject {
    func pushAddTaskVC()
}

final class AddCell: UITableViewCell {

    weak var delegate: AddTableViewCellDelegate?
    static let cellIdentifier = "AddCell"

    // MARK: - Private properties

    private let addButton = UIButton()
    private let addTitle = "+"
    private let addButtonWidth: CGFloat = 50
    private let anchorConst: CGFloat = 8

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc private func addButtonTapped() {
        addButton.createAnimation(scale: 0.9)
        delegate?.pushAddTaskVC()
    }

}

extension AddCell {

    // MARK: - Private methods

    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: anchorConst),
            addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: addButtonWidth),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -anchorConst)
        ])
        addButton.setTitle(addTitle, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 30)
        addButton.titleLabel?.textAlignment = .center
        addButton.backgroundColor = .systemPink
        addButton.layer.cornerRadius = addButtonWidth / 2
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

}
