//
//  MainViewController.swift
//  Composite
//
//  Created by Anton Chechevichkin on 06.09.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    var generalTaskStorage: [Tasks] = []
    var localTaskStorage: [Tasks] = []
    var currentTask : TaskPresenter?
    var levelTask: Int = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var levelTitle: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier:  TaskTableViewCell.reuseId)
    }
    
    @IBAction func goFirstTask(_ sender: Any) {
        if levelTask == 0 { return }
        
        levelTask = 0
        levelTitle.title = "Level #" + String(levelTask)
        localTaskStorage = generalTaskStorage
        tableView.reloadData()
    }
    @IBAction func addTask(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            
            if self?.levelTask == 0 {
                self?.localTaskStorage = []
                let localTask = TaskPresenter(taskName: "Task #"+String(self!.generalTaskStorage.count), taskCount: "0")
                self?.generalTaskStorage.append(localTask)
                self?.localTaskStorage = self!.generalTaskStorage
            } else {
                let localTask = TaskPresenter(taskName: (self?.currentTask!.taskName)!+"->"+String(self!.localTaskStorage.count), taskCount: "0")
                self?.localTaskStorage.append(localTask)
                self?.currentTask?.subTask = self!.localTaskStorage
                self?.currentTask?.taskCount = String(self!.localTaskStorage.count)
            }
            
            self?.tableView.reloadData()
        }
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localTaskStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        DispatchQueue.main.async { [weak self] in
            self?.configure(cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    private func configure(cell: TaskTableViewCell,indexPath: IndexPath)  {
        cell.taskName.text? = localTaskStorage[indexPath.row].taskName
        cell.taskCount.text? = localTaskStorage[indexPath.row].taskCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newLevel(indexPath: indexPath)
    }
    
    private func newLevel(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.levelTask += 1
            self?.currentTask = self?.localTaskStorage[indexPath.row] as? TaskPresenter
            self?.localTaskStorage = (self?.currentTask!.subTask)!  
            self?.tableView.reloadData()
            self?.levelTitle.title = "Level #"+String(self!.levelTask)
        }
    }
}



