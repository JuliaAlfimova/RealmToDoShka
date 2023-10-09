//
//  Data.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 22.09.2023.
//

import Foundation
import RealmSwift

//class Task: Object {
//
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var name: String = ""
//    @Persisted var status: Bool = false
//    @Persisted var ownerId: String
//
//    convenience init(name: String, ownerId: String) {
//        self.init()
//        self.name = name
//        self.ownerId = ownerId
//    }
//
//}

class Task: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var status: Bool = false
}
