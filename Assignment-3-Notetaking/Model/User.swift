//
//  User.swift
//  Assignment-3-Notetaking
//
//  Created by Luke Phillips on 15/5/2022.
//

import Foundation

class User {
    var id = UUID().uuidString
    var name: String
    var pass: String
    var notesArray: [Note] = []
    
    init(username: String, password: String) {
        name = username
        pass = password
    }
    
    func addNote(note: Note) {
        notesArray.append(note)
    }
}
