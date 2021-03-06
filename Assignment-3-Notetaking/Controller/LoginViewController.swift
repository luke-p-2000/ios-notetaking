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
        if UIScreen.main.bounds.height < 600.0 {
            addBackgroundPod()
        } else {
            addBackgroundPhone()
        }
        addBackground1()
        errorLabel.text = ""
        
        //DEBUG CLEAR DEFAULTS
        //UserDefaults.standard.removeObject(forKey: "AllUsers")
        
        // Extract and decode user data from the userdefaults stored array.
        if let data = UserDefaults.standard.data(forKey: "AllUsers") {
            do {
                // Data array is stored in JSON format.
                let decoder = JSONDecoder()
                users = try decoder.decode(Array<User>.self, from: data)
            } catch {
                print("Failed to decode user data. Error: \(error)")
            }
        }
        // Debig print statement.
        print("There are \(users.count) users enrolled.")
    }
    
    // configure and add background image to mainscreen
    func addBackgroundPhone() {
        let image = UIImage(named: "b1")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: -180, width: self.view.bounds.width, height: self.view.bounds.height)
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    func addBackgroundPod() {
        let image = UIImage(named: "b1")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    // configure and add background image to mainscreen
    func addBackground1() {
        let image = UIImage(named: "b1w")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        imageView.contentMode = .scaleToFill
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    func confirmLogin() -> Bool {
        // Guards are defensive against failed text extraction.
        guard let user: String = userField.text else {return false}
        guard let pass = passField.text else {return false}
        
        // Confirm against valid logins.
        if user != "" && pass != "" {
            // Compare to each registered user.
            for userItr in users {
                if userItr.name == user && userItr.pass == pass {
                    // Only a match will allow the segue to proceed.
                    return true
                }
            }
        } else {
            errorLabel.text = "Login failed."
            return false
        }
        errorLabel.text = "Login failed."
        return false
    }
    
    @IBAction func registerButton(_ sender: Any) {
        // Guard used defensively for password only as username may be empty to create a guest.
        let user = userField.text
        guard let pass = passField.text else {
            errorLabel.text = "Must input password."
            return
        }
        
        for user in users {
            if user.name == userField.text {
                errorLabel.text = "User must be unique."
                return
            }
        }
        
        //Append to registered users if password is present.
        if pass != "" {
            // nil coalesce to "Guest" in the event of no entered username.
            let newUser = User(username: user ?? "Guest", password: pass)
            users.append(newUser)
            //Debug output.
            print("There are \(users.count) users enrolled.")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Use the confirmLogin function when the loginSegue is called to allow it to progress.
        if identifier == "loginSegue" {
            return confirmLogin()
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            // Create the view controller instance.
            let VC = segue.destination as! NoteTableViewController
            for user in users {
                if user.name == userField.text {
                    // Assign the view controller instance variable to the logged in user.
                    VC.currentUser = user
                    //print("Sent")
                }
            }
            
            // Encode the users data to JSON and store in UserDefaults to persist.
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(users)
                UserDefaults.standard.set(data, forKey: "AllUsers")
            } catch {
                print("Failed to encode user data. Error: \(error)")
            }
        }
    }
}
