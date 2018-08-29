//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //MARK: Variables
    //*************************************
    var conversation: [Message] = [Message]()

    
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
        messageTextfield.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldDidEndEditing))
        messageTableView.addGestureRecognizer(tapGesture)
        
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
    
    func configureTableView(){
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 100
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    //*************************************

    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    //*************************************
    
    
    
    //MARK: IBActions
    //*************************************
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        //Disable the data entry meanwhile networking is in process
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        //Send message to Firebase
        let messageDB = Database.database().reference().child("Messages")
        let messageDict = ["sender": Auth.auth().currentUser?.email, "message": messageTextfield.text!]
        
        messageDB.childByAutoId().setValue(messageDict) {
            (error, reference) in
            if error != nil {
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            } else {
                self.Alert(title: "Error", error: error!.localizedDescription)
            }
        }
        
    }
    
    //Retrieve messages from Firebase
    func retrieveMessages(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let message = Message()
            message.senderUsername = snapshotValue["sender"]!
            message.messageBody = snapshotValue["message"]!
            
            self.conversation.append(message)
        }
        
        
    }

    
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
