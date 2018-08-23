//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import FirebaseAuth


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //MARK: Variables
    //*************************************

    
    //MARK: IBOutlets
    //*************************************
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegates
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //TODO: Set yourself as the delegate of the text field here:
        //TODO: Set the tapGesture here
        
        //Register MessageCell.xib file
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        //UIConfig for TableView
        configureTableView()
    }
    
    //MARK: - TableView DataSource Methods
    //*************************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        let initialText = ["Test1", "Test2", "Test3"]
        cell.messageBody.text = initialText[indexPath.row]
        
        return cell
    }
    
    
    
    //TODO: Declare tableViewTapped here:
    
    
    
    //TODO: Declare configureTableView here:
    func configureTableView(){
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 100
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    //*************************************
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    
    
    
    
    //TODO: Declare textFieldDidEndEditing here:
    

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    //*************************************
    
    
    
    //MARK: IBActions
    //*************************************
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        
        //TODO: Send the message to Firebase and save it in our database
        
        
    }
    
    //TODO: Create the retrieveMessages method here:

    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        //Logout user
        do {
            try
                Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: true)
        } catch {
            Alert(title: "Error", error: "\(error)")
        }
    }
    
    //MARK: Alert
    //*************************************

    func Alert(title: String, error: String) {
        let alert = UIAlertController(title: "\(title)", message: "\(error)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Let me try again!", style: .cancel, handler: nil))
    }
    


}
