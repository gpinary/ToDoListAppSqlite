//
//  MainPageViewModel.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 10.08.2023.
//

import Foundation
import RxSwift

class MainPageViewModel{
    var trepo = TodoDaoRepository()
    var todoList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    init(){
        copyDatabase()
        todoList = trepo.TodoList

    }
    
    func delete(todo_id:Int) {
        trepo.delete(todo_id: todo_id)
        loadTodo()
    }
    func search(searchKey:String){
        trepo.search(searchKey: searchKey)
    }
    func loadTodo() {
        trepo.loadTodo()
    }
    func copyDatabase() {
        let bundlePath = Bundle.main.path(forResource: "Todolist", ofType: ".sqlite")
        
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: filePath).appendingPathComponent("Todolist.sqlite")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath: databaseURL.path()) {
            print("Database is already exist.")
            
        }else{
            do{
                try fm.copyItem(atPath: bundlePath!, toPath: databaseURL.path)
            }catch{
                print(error.localizedDescription)
            }

        }
        
        
    }
}
