//
//  TaskTableViewCell.swift
//  Composite
//
//  Created by Anton Chechevichkin on 06.09.2022.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    static let reuseId = "TaskTableViewCell"
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskCount: UILabel!
    
}
