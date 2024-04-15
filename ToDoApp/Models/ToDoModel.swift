//
//  ToDoModel.swift
//  TestTask
//
//  Created by Mac on 28.03.2024.
//

import RealmSwift

final class ToDoModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var explanation: String = ""
    @Persisted var isReady: Bool = false
    
    override class func primaryKey() -> String? {
        "id"
    }
}
