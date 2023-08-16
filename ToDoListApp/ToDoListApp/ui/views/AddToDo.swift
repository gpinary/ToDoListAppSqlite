//
//  AddToDo.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 31.07.2023.
//

import UIKit

class AddToDo: UIViewController {
    
    @IBOutlet weak var tfAddToDo: UITextField!
    
    var viewModel = AddToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveButton(_ sender: Any) {
        if let tn = tfAddToDo.text {
            viewModel.save(todo_name: tn)
        }
    }
    
}
