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
    var userNote = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = note.title
        contentField.text = note.content
        remindDate.date = note.reminder ?? Date()
        loadDrawing()
    }
    
    @IBAction func reminderUpdate(_ sender: Any) {
        note.reminder = remindDate.date
    }
    
    @IBAction func deleteButtonPress(_ sender: Any) {
        deleteNote(noteToDel: note)
        //call segue to tableview "popLibrary"
        
    }
    
    @IBAction func drawOnClick(_ sender: Any) {
        print(note.getTitle())
        UserDefaults.standard.set(note.getTitle(), forKey: "note")
        performSegue(withIdentifier: "drawSegue", sender: nil)
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
    
    func loadDrawing(){
        userNote = UserDefaults.standard.value(forKey: "snapshot") as? [String : Any] ?? [note.getTitle() : "test"]
        
        //var noteName = Array(userNote.keys)
        //var noteData = Array(userNote.values)
        //print(userNote)
        
        for(key, value) in userNote{
            if key == note.getTitle(){
                if let data = value as? Data, let image = UIImage(data: data){ //UserDefaults.standard.data(forKey: "snapshot"), let image = UIImage(data: data) {
                    
                    let uiimage = UIImageView(frame: CGRect(x: 10, y: 50, width: 100, height: 300))
                    //let uiimage = UIImageView()
                    uiimage.image = image as? UIImage
                
                    
                    self.view.addSubview(uiimage)
                    //uiimage.translatesAutoresizingMaskIntoConstraints = false
                    
                }
            }
        }
        
        
    }
}
