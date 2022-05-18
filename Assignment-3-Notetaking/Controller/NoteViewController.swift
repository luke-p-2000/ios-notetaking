//
//  NoteViewController.swift
//  Assignment-3-Notetaking
//
//  Created by Luke Phillips on 13/5/2022.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var remindDate: UIDatePicker!
    
    var currentUser: User = User(username: "Steve", password: "Ipsum")
    var note: Note = Note(titleIn: "Placeholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = note.title
        contentField.text = note.content
        remindDate.date = note.reminder ?? Date()
    }
    
    @IBAction func reminderUpdate(_ sender: Any) {
        note.reminder = remindDate.date
    }
    
    @IBAction func deleteButtonPress(_ sender: Any) {
        deleteNote(noteToDel: note)
        //call segue to tableview "popLibrary"
        
    }
    
    func saveNote() {
        var idx: Int = 0
        note.setContent(input: contentField.text)
        //Check each note in the notes array overwrite note data.
        for noteItr in currentUser.notesArray {
            if noteItr.id == note.id {
                currentUser.notesArray[idx] = note
            }
            idx += 1
        }
    }
    
    func deleteNote(noteToDel: Note) {
        var idx: Int = 0
        for noteItr in currentUser.notesArray {
            if noteItr.id == noteToDel.id {
                currentUser.notesArray.remove(at: idx)
                break
            }
            idx += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popLibrary" {
            let VC = segue.destination as! NoteTableViewController
            saveNote()
            VC.currentUser = currentUser
        }
    }
}
