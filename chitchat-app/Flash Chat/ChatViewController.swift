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
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegates
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        //Tap gesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        //UIConfig for TableView
        configureTableView()
        messageTableView.separatorStyle = .none
        
        //Get data
        retrieveMessages()
    }
    
    //MARK: - TableView DataSource Methods
    //*************************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = conversation[indexPath.row].messageBody
        cell.senderUsername.text = conversation[indexPath.row].senderUsername
        cell.avatarImageView.image = UIImage(named: "egg")
        
        return cell
    }
    
    func configureTableView(){
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    //*************************************

    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageTextfield.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //Getting keyboard height for textField animation
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            UIView.animate(withDuration: 0.5) {
                self.heightConstraint.constant = keyboardHeight + 50
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    //Animation: close keyboard tapping out
    @objc func tableViewTapped(){
        messageTextfield.endEditing(true)
    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    //*************************************
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        //Disable the data entry meanwhile networking is in process
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        //Send message to Firebase
        let messageDB = Database.database().reference().child("Messages")
        let messageDict = ["senderUsername": Auth.auth().currentUser?.email, "messageBody": messageTextfield.text!]
        
        messageDB.childByAutoId().setValue(messageDict) {
            (error, ref) in
            if error == nil {
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            } else {
                self.Alert(title: "Error", error: error!.localizedDescription)
            }
        }
        
    }
    
    func retrieveMessages(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let message = Message()
            message.senderUsername = snapshotValue["senderUsername"]!
            message.messageBody = snapshotValue["messageBody"]!
            self.conversation.append(message)
            
            //Reload tableView
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }

    //Logout
    @IBAction func logOutPressed(_ sender: AnyObject) {
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
