//
//  UpdateToDoViewModel.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 10.08.2023.
//

import Foundation

class UpdateToDoViewModel {
    var trepo = TodoDaoRepository()
    
    func update(todo_id:Int,todo_name:String){
        trepo.update(todo_id: todo_id, todo_name: todo_name)
    }
}
