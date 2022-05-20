//
//  NoteTableViewController.swift
//  Assignment-3-Notetaking
//
//  Created by Luke Phillips on 13/5/2022.
//

import UIKit

class NoteTableViewController: UITableViewController {

    var currentUser: User = User(username: "Lorem", password: "Ipsum")
    var selectedNote: Int = 0
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Import users data to users array from userdefaults.
        if let data = UserDefaults.standard.data(forKey: "AllUsers") {
            do {
                // Data array is stored in JSON format.
                let decoder = JSONDecoder()
                users = try decoder.decode(Array<User>.self, from: data)
            } catch {
                print("Failed to decode user data. Error: \(error)")
            }
        }
        
        //Debug Prints
        for note in currentUser.notesArray {
            print("\(note.title), ")
        }
        print("Welcome, \(currentUser.name).")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser.notesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let note = currentUser.notesArray[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = indexPath.row
        performSegue(withIdentifier: "openNote", sender: nil)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
    
    @IBAction func addNoteButton(_ sender: Any) {
        let alert = UIAlertController(title: "New Note", message: "Note Title", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "My Note"
        }
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak alert] (_) in guard let textField = alert?.textFields?[0], let userText = textField.text else {return}
            self.currentUser.notesArray.append(Note(titleIn: userText))
            print("Added \(self.currentUser.notesArray[self.currentUser.notesArray.count-1].title)")
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func logoutUser() {
        // Update the user in the users array to add new notes.
        var idx = 0
        for user in users {
            if user.name == currentUser.name {
                users[idx] = currentUser
            }
            idx += 1
        }
        
        // Rewrite updated users to userdefaults.
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(users)
            UserDefaults.standard.set(data, forKey: "AllUsers")
        } catch {
            print("Failed to encode user data. Error: \(error)")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openNote" {
            let VC = segue.destination as! NoteViewController
            VC.note = currentUser.notesArray[selectedNote]
            VC.currentUser = currentUser
        }
        if segue.identifier == "logoutSegue" {
            logoutUser()
        }
    }
    
}
