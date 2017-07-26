//
//  LoginViewController.swift
//  wordguess practice
//
//  Created by Sahana Murthy on 7/18/17.
//  Copyright © 2017 Sahana Murthy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func action(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != "" {
            if segmentControl.selectedSegmentIndex == 0 //Login 
            {
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                    else {
                        if let myError = error?.localizedDescription {
                            self.createAlert(title: "Error", message: myError)
                            print(myError)
                        }
                        else {
                            self.createAlert(title: "Error", message: "error")
                            print("ERROR")
                        }
                    }
                }

            }
            else //Sign Up
            {
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                    else {
                        if let myError = error?.localizedDescription {
                            self.createAlert(title: "Error", message: myError)
                            print(myError)
                        }
                        else {
                            self.createAlert(title: "Error", message: "error")
                            print("ERROR")
                        }
                    }

                })
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailText.delegate = self
        self.passwordText.delegate = self
    }
    
    func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
