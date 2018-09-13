//
//  ViewController.swift
//  get****done-app
//
//  Created by Lucas Cotta on 9/11/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    //MARK: Variables
    var listArray = ["Clean Room", "Clean Living Room", "Buy Tomatoes"]
    
    
    //MARK: IBOutlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = listArray[indexPath.row]
        
        return cell
    }
    
    //MARK: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Add ticker
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add Items
    @IBAction func addButtonTapped(_ sender: Any) {
        
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "New **** to get done!", message: "Please insert below", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
                self.listArray.append(textField.text ?? "New Item")
                self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (alertTextField) in
            alertTextField.placeholder = ""
            textField = alertTextField
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    

}

