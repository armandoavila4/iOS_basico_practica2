//
//  ToDoTaskCell.swift
//  CoreDataList
//
//  Created by Jorge Armando Avila Estrada on 17/12/22.
//

import UIKit

class ToDoTaskCell: UITableViewCell {

    
    @IBOutlet weak var taskTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
