//
//  NoteTableViewController.swift
//  Assignment-3-Notetaking
//
//  Created by Luke Phillips on 13/5/2022.
//

import UIKit

class NoteTableViewController: UITableViewController {

    var currentUser: User = User(username: "Lorem", password: "Ipsum")
    var userNotes: [Note] = []
    var selectedNote: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull stored notes for current user.
        userNotes = currentUser.notesArray
        
        userNotes.append(Note(titleIn: "Placeholder"))
        
        //Debug Prints
        for note in userNotes {
            print("\(note.title), ")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let note = userNotes[indexPath.row]
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
            self.userNotes.append(Note(titleIn: userText))
            print("Added \(self.userNotes[self.userNotes.count-1].title)")
        }))
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openNote" {
            let VC = segue.destination as! NoteViewController
            VC.note = userNotes[selectedNote]
            VC.currentUser = currentUser
        }
    }

}
