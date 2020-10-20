//
//  EditViewController.swift
//  FireTodo
//
//  Created by Tarokh on 10/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class EditViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var colorSegmentedControl: UISegmentedControl!
    @IBOutlet var closeBarButtonItem: UIBarButtonItem!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    
    
    //MARK: - Variables
    var todoTitle: String?
    var todoDescription: String?
    var todoColor: String?
    var ref: DatabaseReference?
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference(withPath: "ToDo")
        
        todoTitle = UserDefaults.standard.value(forKey: "todoTitle") as? String
        todoDescription = UserDefaults.standard.value(forKey: "description") as? String
        
        titleTextField.text = todoTitle!
        descriptionTextField.text = todoDescription!
        colorSegmentedControl.selectedSegmentIndex = 1
        
        print("The id is: \(UserDefaults.standard.value(forKey: "id") as! String)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Edit Task"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Functions
    @IBAction func colorValueChanged(_ sender: Any) {
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let autoID = UserDefaults.standard.value(forKey: "id") as? String else {return}
        guard let todoTitle = titleTextField.text else {return}
        guard let todoDescription = descriptionTextField.text else {return}
        guard let selectedColorValue = colorSegmentedControl.titleForSegment(at: colorSegmentedControl.selectedSegmentIndex) else {return}
        let listRef = self.ref?.child(autoID)
        listRef?.updateChildValues(["todoItem": todoTitle, "description": todoDescription, "completed": false, "selectedColor": selectedColorValue])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
