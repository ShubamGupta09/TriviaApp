//
//  QuestionTableViewController.swift
//  TriviaApp
//
//  Created by Shubam Gupta on 14/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit

enum Question {
    // Two Different Questions
    case favCriketer
    case flagColor
}

class QuestionTableViewController: UITableViewController {

    var favCriketPerson: Int!
    var flagClr: [Int] = []
    var time: String!
    var name: String!
   
    var quiz: Question = .favCriketer {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Outlet
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetUp()
    }
    
    func tableViewSetUp() {
        // Corner Radius
        btnSubmit.layer.cornerRadius = 25
        btnSubmit.isEnabled = false
        //Register TableViewCell
        tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionTableViewCell")
        // Constant Height of the TableVew
        self.tableView.sectionHeaderHeight = 70
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FavCricketPlayer screen
        if quiz == .favCriketer {
            return Constant.questionOption1.count
        } else {
            // FlagColor Screen
            return Constant.questionOption2.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as? QuestionTableViewCell {
            // FavCricketPlayer
            if quiz == .favCriketer {
              cell.lblOptions.text = Constant.questionOption1[indexPath.row]
              // Update Image in button
              if favCriketPerson == indexPath.row {
                  cell.btnAnswer.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
              } else {
                  cell.btnAnswer.setImage(#imageLiteral(resourceName: "circle"), for: .normal)
              }
            } else {
                // ColorFlag Screen
                cell.lblOptions.text = Constant.questionOption2[indexPath.row]
                // Update Image in button
                if flagClr.contains(indexPath.row) {
                    cell.btnAnswer.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
                } else {
                    cell.btnAnswer.setImage(#imageLiteral(resourceName: "circle"), for: .normal)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // Header where question populate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
            let label = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width - 40, height: 50))
            if quiz == .favCriketer {
                label.text = Constant.question1
            } else {
                label.text = Constant.question2
            }
            label.textColor = UIColor.black
            label.font = .boldSystemFont(ofSize: 16)
            view.addSubview(label)
            return view
    }
    
    //Selection of TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if quiz == .favCriketer {
            btnSubmit.isEnabled = true
            favCriketPerson = indexPath.row
            tableView.reloadData()
        } else {
            if flagClr.contains(indexPath.row) {
                // If the array contains then will remove
                btnSubmit.isEnabled = false
                flagClr.removeAll{$0 == indexPath.row}
            } else {
                
                flagClr.append(indexPath.row)
                //FlagColor Should have more than one options
                if flagClr.count >= 2 {
                    btnSubmit.isEnabled = true
                } else {
                    btnSubmit.isEnabled = false
                }
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func btnActionSubmit(_ sender: Any) {
        if quiz == .favCriketer {
            // Once Submit Clicked Change to FlagColor Question
            quiz = .flagColor
            btnSubmit.isEnabled = false
        } else {
            // FavCrcketPerson: Int , getting Answer from Constant
            let responce = Constant.questionOption1[favCriketPerson]
            // FlagColor will be more than one
            var arrResponce: [String] = []
            for responceValue in flagClr {
                arrResponce.append(Constant.questionOption2[responceValue])
            }
            
            // Move from one vc to other
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            vc.answer1 = responce
            vc.answer2 = arrResponce
            vc.time = time
            vc.userName = name
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
