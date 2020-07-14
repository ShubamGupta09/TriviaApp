//
//  ResultViewController.swift
//  TriviaApp
//
//  Created by Shubam Gupta on 14/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit
import CoreData

class ResultViewController: UIViewController {

    //MARK: VARIABLES
    var answer1: String = ""
    var answer2: [String] = []
    var time: String = ""
    var userName: String = ""
    
    var name: [String] = []
    var timeVal: [String] = []
    var favCricketer: [String] = []
    var flagClr: [[String]] = []
    
    //MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveDataInCoreData()
        setUp()
    }
    
    func setUp() {
        //Corner Radius
        btnFinish.layer.cornerRadius = 25
        btnHistory.layer.cornerRadius = 25
        //TableView Delegates and Datasource
        tableView.delegate = self
        tableView.dataSource = self
        //Register Cell
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    //MARK: COREDATA
    func saveDataInCoreData() {
        //SAVE DATA
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        
        newUser.setValue(time, forKey: "time")
        newUser.setValue(userName, forKey: "name")
        newUser.setValue(answer1, forKey: "answer1")
        newUser.setValue(answer2, forKey: "answer2")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        //FetchData
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
               print(data.value(forKey: "answer2") as! [String])
                let userName = data.value(forKey: "name") as! String
                name.append(userName)
                let duration = data.value(forKey: "time") as! String
                timeVal.append(duration)
                let favPlayer = data.value(forKey: "answer1") as! String
                favCricketer.append(favPlayer)
                let flagColor = data.value(forKey: "answer2") as! [String]
                flagClr.append(flagColor)
            }
            
        } catch {
            self.showToast(message: "Failed to Save", font: .systemFont(ofSize: 12.0))
        }
    }
    
    @IBAction func btnActionFinish(_ sender: Any) {
        // One Vc to Other
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActionHistory(_ sender: Any) {
        // One VC to Other
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryTableViewController") as! HistoryTableViewController
        vc.time = timeVal
        vc.userName = name
        vc.answer1 = favCricketer
        vc.answer2 = flagClr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.lblDate.isHidden = true
        cell.lblName.text = "Hello \(userName)"
        cell.lblCriketerAnswer.text = "Answer: \(answer1)"
        let responce = answer2.joined(separator:",")
        cell.lblFlagAnswer.text = "Answer: \(responce)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Automatically it sets the height as per its need
        return UITableView.automaticDimension
    }
}
