//
//  ViewController.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 29.08.2023.
//

import UIKit
import RealmSwift

final class ToDoVC: UIViewController, UIViewControllerTransitioningDelegate {

    let realm = try! Realm()
    var tasks = [Task]()

    // MARK: - Private properties

    private let tableView = UITableView()
    private let editButton = UIButton()
    private let deleteButton = UIButton()

    private let editButtonImage = UIImage(systemName: "square.and.pencil")?.withTintColor(.label, renderingMode: .alwaysOriginal)
    private let doneEditingButtonImage = UIImage(systemName: "checkmark.square")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
    private let deleteButtonImage = UIImage(systemName: "xmark.bin")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)

    private let anchorConst: CGFloat = 8
    private var isEditingMode = false
    private var selectedRows = [Int]()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        renderData()
        setupInterface()
    }

    // MARK: - Actions

    @objc private func editButtonTapped() {
        editButton.createAnimation(scale: 0.1)
        deleteButton.createAnimation(scale: 0.1)
        if isEditingMode {
            endEditingMode()
        } else {
            deleteButton.isHidden = false
            editButton.isSelected = true
            isEditingMode = true
        }
    }

    @objc private func deleteButtonTapped() {
        deleteButton.createAnimation(scale: 0.1)
        for row in selectedRows {
            deleteTask(tasks[row-1].name)
            tasks.remove(at: row-1)
        }
        tableView.reloadData()
        endEditingMode()
    }


}

extension ToDoVC {

    // MARK: - Private methods

    private func setupInterface() {
        view.backgroundColor = .systemBackground
        setupEditButton()
        setupDeleteButton()
        setupTableView()
    }

    private func setupEditButton() {
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -anchorConst)
        ])
        editButton.setImage(editButtonImage, for: .normal)
        editButton.setImage(doneEditingButtonImage, for: .selected)
        editButton.adjustsImageWhenHighlighted = false
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }

    private func setupDeleteButton() {
        view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -anchorConst)
        ])
        deleteButton.setImage(deleteButtonImage, for: .normal)
        deleteButton.adjustsImageWhenHighlighted = false
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.isHidden = true
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: editButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellIdentifier)
        tableView.register(AddCell.self, forCellReuseIdentifier: AddCell.cellIdentifier)
        tableView.backgroundColor = .systemBackground
    }

    private func endEditingMode() {
        deleteButton.isHidden = true
        editButton.isSelected = false
        isEditingMode = false
        for cell in tableView.visibleCells {
            cell.backgroundColor = .clear
        }
        selectedRows.removeAll()
    }

}

extension ToDoVC: StatusTableViewCellDelegate, AddTableViewCellDelegate, AddNewTaskDelegate {

    // MARK: - Delegate methods

    func pushAddTaskVC() {
        let vc = AddTaskVC()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

    func addNewTask(_ title: String) {
        saveData(title)
        let newTask = Task()
        newTask.name = title
        //        tasks.append(newTask)
        tasks.insert(newTask, at: 0)
        tableView.reloadData()
    }

    func changeStatus(cell: TaskCell, status: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            changeStatus(status, for:  tasks[indexPath.row].name)
        }
    }

}

extension ToDoVC: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table View methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddCell.cellIdentifier, for: indexPath) as? AddCell ?? .init()
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellIdentifier, for: indexPath) as? TaskCell ?? .init()
            cell.setData(title: tasks[indexPath.row - 1].name, status: tasks[indexPath.row - 1].status)
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditingMode && indexPath.row != 0 {
            if let cell = tableView.cellForRow(at: indexPath) {
                UIView.animate(withDuration: 0.2) {
                    cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
            }
            selectedRows.append(indexPath.row)
        }
    }
}


