//
//  Note.swift
//  Assignment-3-Notetaking
//
//  Created by Luke Phillips on 13/5/2022.
//

import Foundation

class Note: Codable {
    //Declare note variables.
    var id = UUID().uuidString
    var title: String
    var content: String?
    var created: Date
    var reminder: Date?
    
    init(titleIn: String) {
        self.title = titleIn
        self.created = Date()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Define object functions.
    func setReminder(time: Date) {
        self.reminder = time
    }
    
    func setContent(input: String) {
        self.content = input
    }
    
    func getTitle() -> String{
        return self.title;
    }
}
