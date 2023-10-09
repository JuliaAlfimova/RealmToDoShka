//
//  TaskCell.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 03.10.2023.
//

import UIKit

protocol StatusTableViewCellDelegate: AnyObject {
    func changeStatus(cell: TaskCell, status: Bool)
}

final class TaskCell: UITableViewCell {

    weak var delegate: StatusTableViewCellDelegate?
    static let cellIdentifier = "TaskCell"

    // MARK: - Private properties

    private let headerLabel = UILabel()
    private let statusButton = UIButton()
    private let circleImage = UIImage(systemName: "circle")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
    private let doneImage = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
    private let textSize: CGFloat = 20
    private let statusButtonHeight: CGFloat = 20
    private let anchorConst: CGFloat = 16

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(title: String, status: Bool) {
        headerLabel.text = title
        statusButton.isSelected = status
    }

    // MARK: - Actions

    @objc private func statusButtonTapped() {
        statusButton.isSelected.toggle()
        statusButton.createAnimation(scale: 0.1)
        delegate?.changeStatus(cell: self, status: statusButton.isSelected)
    }

}

extension TaskCell {

    // MARK: - Private methods

    private func setupCell() {
        selectionStyle = .none
        setupButton()
        setupLabel()
    }

    private func setupButton() {
        contentView.addSubview(statusButton)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst),
            statusButton.heightAnchor.constraint(equalToConstant: statusButtonHeight),
            statusButton.widthAnchor.constraint(equalToConstant: statusButtonHeight)
        ])
        statusButton.setImage(circleImage, for: .normal)
        statusButton.setImage(doneImage, for: .selected)
        statusButton.addTarget(self, action: #selector(statusButtonTapped), for: .touchUpInside)
    }

    private func setupLabel() {
        contentView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor, constant: anchorConst),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorConst),
            headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -anchorConst)
        ])
        headerLabel.textColor = .label
        headerLabel.numberOfLines = 0
        headerLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }

}
