//
//  ViewController.swift
//  test1
//
//  Created by Jonathan Nguyen on 16/5/2022.
//
import UIKit

class DrawViewController: UIViewController {

    let canvas = Canvas()
    var note: String = ""
    //var note: Note = Note(titleIn: "Placeholder")
    var userNote = [String : Any]()
    
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button;
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button;
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveOnClick), for: .touchUpInside)
        return button;
    }()
    
    @objc func handleUndo(){
        canvas.undo()
    }
    
    @objc func handleClear(){
        canvas.clear();
    }
    
    override func loadView() {
        self.view = canvas;
    }
    
    func setupLayout(){
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton,
            saveButton,
        ])
        
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = .white
        //UserDefaults.standard.removeObject(forKey: "snapshot")
        //for (key, value) in UserDefaults.standard.
        
        note = UserDefaults.standard.self.object(forKey: "note") as! String
        print("draw " + note)
        
        setupLayout();
    }
     
    
    @objc func saveOnClick() {
        //userNote = UserDefaults.standard.value(forKey: "snapshot") as? [String : Any] ?? [note : "test"]
        
        //for(key, value) in userNote{
         //   if key == note{
         //       UserDefaults.standard.
         //   }
        //}
        
        
        let image = UIGraphicsImageRenderer(bounds: view.bounds).image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        if let data = image.pngData() {
            //userNote = [note : data]
            userNote.updateValue(data, forKey: note)
            UserDefaults.standard.set(userNote, forKey: note)
        }
        //performSegue(withIdentifier: "testSegue", sender: nil);
    }
    

}

