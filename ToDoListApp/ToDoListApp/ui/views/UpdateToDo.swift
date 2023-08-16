//
//  UpdateToDo.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 31.07.2023.
//

import UIKit


class UpdateToDo: UIViewController {
    
    @IBOutlet weak var tfTodoName: UITextField!
    
    var todo:Todo?
    
    var viewModel = UpdateToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let t = todo {
            tfTodoName.text = t.todo_name
        }
    }
    @IBAction func updateButton(_ sender: Any) {
        if let tn = tfTodoName.text, let t = todo {
            viewModel.update(todo_id: t.todo_id!, todo_name: tn)
            
        }
    }

}
