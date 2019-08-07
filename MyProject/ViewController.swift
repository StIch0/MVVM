//
//  ViewController.swift
//  MyProject
//
//  Created by Dev on 31/07/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
    let cellId : String = "cellId"
    var users : [User] = Array()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var userViewModel: UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        dowloadUserData()
        
    }
    func dowloadUserData() -> Void {
        self.userViewModel.getUsers( {
            self.users = Array(self.userViewModel.users)
            self.tableView.reloadData()
        })
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.numberOfItemsToDisplay(in: section)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name.first
        return cell
    }
}

