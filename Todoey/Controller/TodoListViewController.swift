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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
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
        saveItems()
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
                self.saveItems()
                
                let encoder = PropertyListEncoder()
                do {
                    let data = try encoder.encode(self.itemArray)
                    try data.write(to: self.dataFilePath!)
                } catch {
                    print("Error! encoding item array, \(error)")
                }
                
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
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error! encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("There is an error, \(error)")
            }
        }
    }
    
}

