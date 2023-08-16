//
//  TodoCell.swift
//  ToDoListApp
//
//  Created by Gökçe Pınar Yıldız on 3.08.2023.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var labelTodo: UILabel!
    
    @IBOutlet weak var labelTodoId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
