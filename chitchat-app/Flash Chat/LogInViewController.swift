//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import FirebaseAuth


class LogInViewController: UIViewController {

    //MARK: IBOutlets
    //*************************************
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: IBactions
    //*************************************
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        //Login user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authResult, error) in
            if error != nil {
                self.Alert(title: "Error!", error: String(error!.localizedDescription))
            } else {
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
