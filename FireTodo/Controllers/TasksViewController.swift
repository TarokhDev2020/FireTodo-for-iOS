//
//  TasksViewController.swift
//  FireTodo
//
//  Created by Tarokh on 10/4/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import DLRadioButton

class TasksViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var todoTableView: UITableView!
    @IBOutlet var addBarButtonItem: UIBarButtonItem!
    @IBOutlet var signOutBarButtonItem: UIBarButtonItem!
    
    
    //MARK: - Variables
    var todoItems = [Todo]()
    var ref: DatabaseReference?
    var hud: JGProgressHUD?
    private var isChecked: Bool = false
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        hud = JGProgressHUD(style: .dark)
        hud?.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud?.show(in: view, animated: true)
        
        ref = Database.database().reference(withPath: "ToDo")
        
        setUpTodoTableView()
        
        fetchTodoItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    //MARK: - Functions
    
    private func setUpTodoTableView() {
        self.todoTableView.separatorStyle = .none
        self.todoTableView.isHidden = false
        self.todoTableView.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "todoCell")
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
    }
    
    private func fetchTodoItems() {
        ref?.observe(.value, with: { (snapshot) in
            var newLists: [Todo] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let newToDo = Todo(snapshot: snapshot)
                    newLists.append(newToDo!)
                }
            }
            DispatchQueue.main.async {
                self.hud?.dismiss()
                self.todoTableView.isHidden = false
                self.todoItems = newLists
                self.todoTableView.reloadData()
            }
        })
    }
    
    @objc private func toggleCheckbox(sender: DLRadioButton) {
        let item = todoItems[sender.tag]
        let listRef = self.ref?.child(item.id)
        listRef?.updateChildValues(["completed" : sender.isSelected])
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCreate", sender: self)
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "signOut", sender: self)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoCell
        let item = todoItems[indexPath.row]
        cell.checkButton.tag = indexPath.row
        cell.checkButton.isMultipleSelectionEnabled = true
        cell.checkButton.addTarget(self, action: #selector(toggleCheckbox(sender:)), for: .touchUpInside)
        cell.todoView.layer.cornerRadius = 5.0
        cell.todoView.backgroundColor = item.selectedColorValue
        cell.titleLabel.text = item.todoItem
        cell.descriptionLabel.text = item.description
        cell.checkButton.isSelected = item.completed
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = todoItems[indexPath.row]
        print("The id is: \(item.id)")
        UserDefaults.standard.set(item.description, forKey: "description")
        UserDefaults.standard.set(item.todoItem, forKey: "todoTitle")
        UserDefaults.standard.set(item.id, forKey: "id")
        self.performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
}
