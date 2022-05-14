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
    
    var note: Note = Note(titleIn: "Placeholder")
    var allNotes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = note.title
        contentField.text = note.content
        remindDate.date = note.reminder ?? Date()
        
        readNotes()
    }
    
    @IBAction func reminderUpdate(_ sender: Any) {
        note.reminder = remindDate.date
    }
    
    func exitNote() {
        //update the note into the dataset.
        writeNotes()
        //return to the tableview
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        exitNote()
    }
    @IBAction func deleteButtonPress(_ sender: Any) {
        deleteNote(noteToDel: note)
        exitNote()
    }
    
    /* Functions to handle notes from userdefaults. */
    func readNotes() {
        allNotes = UserDefaults.standard.object(forKey: "AllNotes") as? [Note] ?? [Note]()
    }
    func writeNotes() {
        var idx: Int = 0
        for noteItr in allNotes {
            if noteItr.id == note.id {
                allNotes[idx] = note
            }
            idx += 1
        }
        UserDefaults.standard.set(allNotes, forKey: "AllNotes")
    }
    func deleteNote(noteToDel: Note) {
        var idx: Int = 0
        for noteItr in allNotes {
            if noteItr.id == noteToDel.id {
                allNotes.remove(at: idx)
            }
            idx += 1
        }
    }
}
