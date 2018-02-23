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
        func registerUser() {
            if((usernameForm.text?.isEmpty)! || (passwordForm.text?.isEmpty)!)
            {
                let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

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
    }
    
    @IBAction func loginClick(_ sender: Any) {
    
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

}
