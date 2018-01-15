//
//  LoginViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 15/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: userNameTextField.text!,
                           password: passWordTextField.text!) { (user, error) in
        }
        if Auth.auth().currentUser != nil {
            // User is signed in.
            print("user is signed in")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            print("not logged in")
            // No user is signed in.
        }
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        Auth.auth().createUser(withEmail: emailField.text!,
                                                               password: passwordField.text!) { user, error in
                                                                if error == nil {
                                                                    Auth.auth().signIn(withEmail: self.userNameTextField.text!,
                                                                                       password: self.passWordTextField.text!)
                                                                } else { print(error) }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
