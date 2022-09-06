//
//  TaskPresenter.swift
//  Composite
//
//  Created by Anton Chechevichkin on 06.09.2022.
//

import Foundation

final class TaskPresenter: Tasks {
    
    var taskName: String
    var taskCount: String
    var subTask: [Tasks] = []
    var array: [Tasks] = []
    
    init (taskName: String,taskCount: String) {
        self.taskName = taskName
        self.taskCount = taskCount
    }
    
    func read() -> [Tasks] {
        DispatchQueue.global().async { [weak self] in
            for task in self!.subTask {
                self?.array.append(task)
            }
        }
        return array
    }
}



