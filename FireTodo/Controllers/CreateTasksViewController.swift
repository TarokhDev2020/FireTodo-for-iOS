//
//  CreateTasksViewController.swift
//  FireTodo
//
//  Created by Tarokh on 10/4/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class CreateTasksViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var closeBarButtonItem: UIBarButtonItem!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var colorSegmentedControl: UISegmentedControl!
    
    
    //MARK: - Variables
    var ref: DatabaseReference?
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference(withPath: "ToDo")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Create Task"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Functions
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let todoTitle = titleTextField.text else {return}
        guard let description = descriptionTextField.text else {return}
        guard let colorValue = colorSegmentedControl.titleForSegment(at: colorSegmentedControl.selectedSegmentIndex) else {return}
        self.save(todoTitle, description, colorValue, false)
    }
    
    @IBAction func colorValueChanged(_ sender: Any) {
    }
    
    private func save(_ todoTitle: String, _ todoDescription: String, _ color: String, _ completed: Bool) {
        let listRef = self.ref?.childByAutoId()
        let list = Todo(id: listRef!.key!, todoItem: todoTitle, completed: completed, selectedColor: color, description: todoDescription)
        listRef?.setValue(list.toAnyObject())
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
