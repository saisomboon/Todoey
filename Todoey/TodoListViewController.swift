//
//  ViewController.swift
//  Todoey
//
//  Created by Watchara Saisomboon on 16/2/19.
//  Copyright © 2019 Watchara Saisomboon. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Wake up","Buy eggs","Go home"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    //MARK - add new item section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != "" {
                self.itemArray.append(textField.text!)
                self.tableView.reloadData()
            } else {
//                let emptyAlert = UIAlertController(title: "Error!", message: "No item added", preferredStyle: .alert)
//                let emptyAction = UIAlertAction(title: "OK", style: .default, handler: { (emptyAction) in
//                    self.dismiss(animated: true, completion: nil)
//                })
//                emptyAlert.addAction(emptyAction)
//                self.present(emptyAlert, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "fill in new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

