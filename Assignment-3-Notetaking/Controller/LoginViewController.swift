//
//  loginViewController.swift
//  Assignment-3-Notetaking
//
//  Created by Luke Phillips on 15/5/2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        
        users = UserDefaults.standard.object(forKey: "Users") as? [User] ?? [User]()
    }

    func confirmLogin() -> Bool {
        guard let user: String = userField.text else {return false}
        guard let pass = userField.text else {return false}
        
        //Confirm against valid logins.
        if user != "" && pass != "" {
            for userItr in users {
                if userItr.name == user && userItr.pass == pass {
                    return true
                }
            }
        } else {return false}
        return false
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let user = userField.text
        guard let pass = passField.text else {
            errorLabel.text = "Must input password."
            return
        }
        
        //Append to registered users.
        if user != "" && pass != "" {
            let newUser = User(username: user ?? "Guest", password: pass)
            users.append(newUser)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            return confirmLogin()
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            let VC = segue.destination as! NoteTableViewController
            for user in users {
                if user.name == userField.text {
                    VC.currentUser = user
                }
            }
            
            //Write users to memory.
            UserDefaults.standard.set(users, forKey: "AllUsers")
        }
    }
}
