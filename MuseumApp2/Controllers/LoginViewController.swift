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
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginSegue", sender: Any?.self)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) { }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: userNameTextField.text!,
                           password: passWordTextField.text!) { (user, error) in
                            if Auth.auth().currentUser != nil {
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "loginSegue", sender: Any?.self)
                                }
                            } else {
                                let alert = UIAlertController(title: "Deze combinatie van wachtwoord en gebruikersnaam klopt niet!",
                                                              message: "",
                                                              preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "Sluit", style: .default)
                                alert.addAction(cancelAction)
                                self.present(alert, animated: true, completion: nil)
                    }
            }
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Registreren",
                                      message: "Registeren",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Registreer",
                                       style: .default) { action in
                                        
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        Auth.auth().createUser(withEmail: emailField.text!,
                                                               password: passwordField.text!) { user, error in
                                                                if error == nil {
                                                                    Auth.auth().signIn(withEmail: self.userNameTextField.text!,
                                                                                       password: self.passWordTextField.text!)
                                                                } else { print(error as Any) }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Sluit",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "email adres"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "wachtwoord"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
