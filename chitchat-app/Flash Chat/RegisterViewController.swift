//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import FirebaseAuth
import SVProgressHUD


class RegisterViewController: UIViewController {

    
    //MARK: IBOutlets
    //************************************************
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: IBActions
    //************************************************
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        //Registering new user
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authResult, error) in
            if error != nil {
                self.Alert(title: "Error!", error: String(error!.localizedDescription))
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    } 
    
    //MARK: Alert
    //*************************************
    
    func Alert(title: String, error: String) {
        let alert = UIAlertController(title: "\(title)", message: "\(error)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Let me try again!", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }

  

    
    
}
