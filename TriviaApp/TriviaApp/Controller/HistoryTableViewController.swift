//
//  HistoryTableViewController.swift
//  TriviaApp
//
//  Created by Shubam Gupta on 15/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var userName: [String] = []
    var time: [String] = []
    var answer1: [String] = []
    var answer2: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register Cell
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.lblDate.text = "GAME \(indexPath.row + 1) : Date: \(time[indexPath.row])"
        cell.lblName.text = "Hello \(userName[indexPath.row])"
        cell.lblCriketerAnswer.text = "Answer\(answer1[indexPath.row])."
        let responce = answer2[indexPath.row].joined(separator:",")
        cell.lblFlagAnswer.text = "Answer: \(responce)."
        return cell
    }
}
