//
//  LoginViewController.swift
//  parseLab
//
//  Created by Pinky Kohsuwan on 2/21/18.
//  Copyright © 2018 Pinky Kohsuwan. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordForm: UITextField!
    @IBOutlet weak var usernameForm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupclick(_ sender: Any) {
        registerUser()
        self.performSegue(withIdentifier: "loginSegue", sender: nil)

    }
    
        func registerUser() {
            if((usernameForm.text?.isEmpty)! || (passwordForm.text?.isEmpty)!)
            {
               let alertController = UIAlertController(title: "Invaild Username", message: "Username and Password cannot be empty.", preferredStyle: .alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                    self.usernameForm.text = ""
                    self.passwordForm.text = ""
                }
            }

            // initialize a user object
            let newUser = PFUser()
            
            // set user properties
            newUser.username = usernameForm.text
            //User email field was optional, PFuser does have it if needed in future
            //newUser.email = emailLabel.text
            newUser.password = passwordForm.text
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
        }
    
    
    @IBAction func loginClick(_ sender: Any) {
        loginUser()
        self.performSegue(withIdentifier: "loginSegue", sender: nil)

}

    
        func loginUser() {
            
            let username = usernameForm.text ?? ""
            let password = passwordForm.text ?? ""
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                }
            }
        }
    }


