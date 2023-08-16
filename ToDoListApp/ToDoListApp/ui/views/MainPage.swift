//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 31.07.2023.
//

import UIKit

class MainPage: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var todoTableView: UITableView!
    
    var todoList = [Todo]()
    
    var viewModel = MainPageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        todoTableView.delegate = self
        todoTableView.dataSource = self

        _ = viewModel.todoList.subscribe(onNext: {list in
            self.todoList = list
            self.todoTableView.reloadData()
        })

    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadTodo()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            //Any--> super class
            //Todo --> sub class
            // Downcasting super --> sub
            if let todo = sender as? Todo { //Soru isareti varsa  nil yapıyor
                let toVC = segue.destination as! UpdateToDo//Downcasting
                toVC.todo = todo
            }
        }
    }
    
}

extension MainPage : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchKey: searchText)
    }
    
}

extension MainPage : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todoList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoCell
        cell.labelTodo.text = todo.todo_name
        cell.labelTodoId.text = "\(todo.todo_id ?? 0)"

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: todo)
        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:"Delete"){contextual,view,bool in
            let todo = self.todoList[indexPath.row]
            
            let alert = UIAlertController(title: "Delete process", message: "You are deleting todo number:\(todo.todo_id!). Are you sure?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let acceptAction = UIAlertAction(title: "Accept", style: .destructive){ action in
                self.viewModel.delete(todo_id: todo.todo_id!)
                
            }
            alert.addAction(acceptAction)
            
            self.present(alert,animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
