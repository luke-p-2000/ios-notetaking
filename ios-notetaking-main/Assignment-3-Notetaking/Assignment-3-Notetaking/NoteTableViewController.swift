//
//  NoteTableViewController.swift
//  Assignment-3-Notetaking
//
//  Created by Luke Phillips on 13/5/2022.
//

import UIKit

class NoteTableViewController: UITableViewController {

    var userNotes: [Note] = []
    var selectedNote: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull stored notes from userdefaults
        userNotes = UserDefaults.standard.object(forKey: "AllNotes") as? [Note] ?? [Note]()
        
        //Create a default note.
        userNotes.append(Note(titleIn: "Placeholder"))
        userNotes[0].setContent(input: "This is my note.")
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openNote" {
            let VC = segue.destination as! NoteViewController
            VC.note = userNotes[selectedNote]
        }
    }

}
