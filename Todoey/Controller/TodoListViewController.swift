//
//  ViewController.swift
//  Todoey
//
//  Created by Watchara Saisomboon on 16/2/19.
//  Copyright © 2019 Watchara Saisomboon. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "Awake"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Eat"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Sleep"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        //replace above with these 5 lines
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new item section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != "" {
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            self.dismiss(animated: true, completion: nil)
        }
//        let randomAction = UIAlertAction(title: "Random", style: .default) { (cancel) in
//            self.dismiss(animated: true, completion: nil)
//        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "fill in new item"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
//        alert.addAction(randomAction)
        present(alert, animated: true, completion: nil)
    }
    
}

