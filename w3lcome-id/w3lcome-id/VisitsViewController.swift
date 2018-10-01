//
//  VisitsViewController.swift
//  w3lcome-id
//
//  Created by Lucas Cotta on 9/28/18.
//  Copyright © 2018 Cotival Solutions GmbH. All rights reserved.
//

import UIKit

class VisitsViewController: UITableViewController {
    
    // MARK: Variables
    var visitTest = [String:String]()
    
    // MARK: IBOutlets
    
    @IBOutlet weak var visitImage: UIImageView!
    @IBOutlet weak var visitName: UITextField!
    @IBOutlet weak var visitCompany: UITextField!
    @IBOutlet weak var visitDate: UITextField!
    @IBOutlet weak var visitTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: Table view methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "visitCell", for: indexPath)
        
        
        
        return cell
    }


}

