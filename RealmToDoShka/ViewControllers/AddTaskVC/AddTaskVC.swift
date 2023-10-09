//
//  AddTaskVC.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 09.10.2023.
//

import UIKit

protocol AddNewTaskDelegate: AnyObject {
    func addNewTask(_ title: String)
}

final class AddTaskVC: UIViewController {

    weak var delegate: AddNewTaskDelegate?

    // MARK: - Private properties

    private let taskInputView = InputView()
    private let addButton = UIButton()

    private let taskInputText = "To do..."
    private let addTitle = "Add"
    private let inputHeight: CGFloat = 80
    private let addButtonHeight: CGFloat = 50
    private let anchorConst: CGFloat = 16

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    // MARK: - Actions

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if taskInputView.isFirstResponder {
            taskInputView.resignFirstResponder()
        }
    }

    @objc private func addButtonTapped() {
        addButton.createAnimation(scale: 0.9)
        if let input = taskInputView.getInput()  {
            delegate?.addNewTask(input)
        }
        dismiss(animated: true, completion: nil)
    }

    
}

extension AddTaskVC {

    // MARK: - Private methods

    private func setupInterface() {
        view.backgroundColor = .systemBackground
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        setupTaskTextField()
        setupAddButton()
    }

    private func setupTaskTextField() {
        view.addSubview(taskInputView)
        taskInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: anchorConst),
            taskInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: anchorConst),
            taskInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -anchorConst),
            taskInputView.heightAnchor.constraint(equalToConstant: inputHeight)
        ])
        taskInputView.setLabelText(taskInputText)
    }

    private func setupAddButton() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: taskInputView.bottomAnchor, constant: anchorConst),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: anchorConst),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -anchorConst),
            addButton.heightAnchor.constraint(equalToConstant: addButtonHeight)
        ])
        addButton.setTitle(addTitle, for: .normal)
        addButton.titleLabel?.textAlignment = .center
        addButton.backgroundColor = .systemPink
        addButton.layer.cornerRadius = addButtonHeight / 2
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

}
