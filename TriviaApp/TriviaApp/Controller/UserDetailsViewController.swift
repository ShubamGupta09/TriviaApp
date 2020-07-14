//
//  UserDetailsViewController.swift
//  TriviaApp
//
//  Created by Shubam Gupta on 14/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit


class UserDetailsViewController: UIViewController {

   //MARK: Outlet
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Corner Radius
        btnSubmit.layer.cornerRadius = 25
    }
    
    //Hide Navigation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    //Show Navigation
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Current Date and Time with return String
    func currentDateandTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        let result = formatter.string(from: date)
        print("\(result)")
        return result
    }
    
    
    //MARK: Action
    @IBAction func btnActionSubmit(_ sender: Any) {
        // Validation for Textfield
        guard let username = tfName.text, !username.isEmpty else {
            self.showToast(message: "Enter UserName", font: .systemFont(ofSize: 12.0))
            return
        }
        
        //Getting Date and Time
        let date = currentDateandTime()
        
        // Dismiss Keyboard
        tfName.resignFirstResponder()
        
        // Move from one vc to other
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionTableViewController") as! QuestionTableViewController
        vc.time = date // Date
        vc.name = username // UserName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIViewController {

// Toast
func showToast(message : String, font: UIFont) {
    // Label Frame
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
