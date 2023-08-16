//
//  TodoDaoRepository.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 10.08.2023.
//

import Foundation
import RxSwift

class TodoDaoRepository {
    var TodoList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    let db:FMDatabase?
    
    init(){
        
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: filePath).appendingPathComponent("Todolist.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    func save(todo_name: String) {
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO Todo (todo_name) VALUES (?)", values: [todo_name])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func update(todo_id:Int,todo_name:String){
        db?.open()
        do{
            try db!.executeUpdate("UPDATE Todo SET todo_name = ? WHERE todo_id = ?", values: [todo_name,todo_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func delete(todo_id:Int) {
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM Todo WHERE todo_id = ?", values: [todo_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func search(searchKey:String){
        db?.open()
        var list = [Todo]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM Todo WHERE todo_name like '%\(searchKey)%'", values: nil)
            
            while result.next(){
                let todo_id = Int(result.string(forColumn: "todo_id"))!
                let todo_name = result.string(forColumn: "todo_name")!
                
                
                let todo = Todo(todo_id: todo_id, todo_name: todo_name)
                list.append(todo)
            }
            
            TodoList.onNext(list) //Trigger

        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func loadTodo() {
        db?.open()
        var list = [Todo]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM Todo", values: nil)
            
            while result.next(){
                let todo_id = Int(result.string(forColumn: "todo_id"))!
                let todo_name = result.string(forColumn: "todo_name")!
                
                
                let todo = Todo(todo_id: todo_id, todo_name: todo_name)
                list.append(todo)
            }
            
            TodoList.onNext(list) //Trigger

        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
