//
//  AddToDoViewModel.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 10.08.2023.
//

import Foundation

class AddToDoViewModel {
    
    var trepo = TodoDaoRepository()
    
    func save(todo_name: String) {
        trepo.save(todo_name: todo_name)
    }
}
