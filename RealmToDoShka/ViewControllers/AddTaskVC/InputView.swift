//
//  InputView.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 09.10.2023.
//

import UIKit

// мне просто нравится как я анимировала эту штучку поэтому вставлю сюда

final class InputView: UIView {

    // MARK: - Private properties

    private let textField = UITextField()
    private let label = UILabel()
    private let anchorConstant: CGFloat = 16
    private var labelCenterYConstraint = NSLayoutConstraint()
    private var labelBottomConstraint = NSLayoutConstraint()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc func viewTapped() {
        setupViewWithInput()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            labelBottomConstraint.isActive = false
            textField.removeFromSuperview()
            setupViewWithoutInput()
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

}

extension InputView: UITextFieldDelegate {

    // MARK: - Public methods

    func setLabelText(_ text: String) {
        label.text = text
    }

    func getInput() -> String? {
        if let text = textField.text, !text.isEmpty {
            return text
        } else {
            return nil
        }
    }

    func clearText() {
        textField.text = ""
        setupViewWithInput()
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }

    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 5
        layer.borderColor = UIColor.label.withAlphaComponent(0.1).cgColor
        layer.borderWidth = 1

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGestureRecognizer)

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        setupViewWithoutInput()

        label.textColor = .label.withAlphaComponent(0.5)
    }

    private func setupViewWithoutInput() {
        labelCenterYConstraint = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: anchorConstant),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -anchorConstant),
            labelCenterYConstraint
        ])
    }

    private func setupViewWithInput() {

        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        labelCenterYConstraint.isActive = false
        labelBottomConstraint = label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -4)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: anchorConstant),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -anchorConstant),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            labelBottomConstraint
        ])

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        textField.becomeFirstResponder()
    }

}
