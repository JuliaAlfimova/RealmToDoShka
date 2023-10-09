//
//  ToDoVCData.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 03.10.2023.
//

import RealmSwift
import Foundation

extension ToDoVC {

    func renderData() {
        let newTasks = realm.objects(Task.self)
        tasks = Array(newTasks.reversed())
    }

    func saveData(_ taskName: String) {
        let todo = Task()
        todo.name = taskName
        todo.status = false
        realm.beginWrite()
        realm.add(todo)
        try! realm.commitWrite()
    }

    func changeStatus(_ status: Bool, for taskName: String) {
        // change for not unique tasks
        if let objectToUpdate = realm.objects(Task.self).filter("name == %@", taskName).first {
            try! realm.write {
                objectToUpdate.status = status
            }
        }
    }

    func updateData() {
        realm.beginWrite()
        realm.delete(realm.objects(Task.self))
        for task in tasks {
            realm.add(task)
        }
        try! realm.commitWrite()
    }

    func deleteTask(_ taskName: String) {
        realm.beginWrite()
        if let objectToDelete = realm.objects(Task.self).filter("name == %@", taskName).first {
            realm.delete(objectToDelete)
        }
        try! realm.commitWrite()
    }

    func deleteAll() {
        realm.beginWrite()
        realm.delete(realm.objects(Task.self))
        try! realm.commitWrite()
    }

}
