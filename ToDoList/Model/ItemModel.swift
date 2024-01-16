//
//  ItemModel.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 15/01/24.
//

import Foundation

//Immutable STruct
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool

    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
    }

    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
