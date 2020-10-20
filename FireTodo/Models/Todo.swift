//
//  Todo.swift
//  FireTodo
//
//  Created by Tarokh on 10/4/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct Todo {
    
    // define some variables
    let ref: DatabaseReference?
    var id: String
    let todoItem: String
    let completed: Bool
    let selectedColor: String
    let description: String
    
    init(id: String, todoItem: String, completed: Bool, selectedColor: String, description: String) {
        self.ref = nil
        self.id = id
        self.todoItem = todoItem
        self.completed = completed
        self.selectedColor = selectedColor
        self.description = description
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String:AnyObject],
            let id = value["id"] as? String,
            let todoItem = value["todoItem"] as? String,
            let completed = value["completed"] as? Bool,
            let selectedColor = value["selectedColor"] as? String,
            let description = value["description"] as? String
            else {return nil}
        self.ref = snapshot.ref
        self.id = id
        self.todoItem = todoItem
        self.completed = completed
        self.selectedColor = selectedColor
        self.description = description
    }
    
    func toAnyObject() -> Any {
        return ["id": id, "todoItem": todoItem, "completed": completed, "selectedColor" : selectedColor, "description": description]
    }
    
    var selectedColorValue: UIColor {
        switch selectedColor {
        case "Red":
            return .red
        case "Blue":
            return .systemBlue
        case "Green":
            return .green
        case "Yellow":
            return .yellow
        default:
            return .white
        }
    }
    
}
