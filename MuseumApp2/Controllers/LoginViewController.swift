//
//  LoginViewController.swift
//  MuseumApp2
//
//  Initial view controller where users can log in or create accounts.
//
//  Created by David van der Velden on 15/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check if user is already signed in, if so, go to Collections view controller.
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginSegue", sender: Any?.self)
            }
        }
    }
    
    // Hides keyboard when touching background.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // If username and password are correct go to Collection view controller.
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
    
    // Open a UIAlert in which users can register their account, which is saved in Firebase.
    @IBAction func signUpPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Registreren", message: "Registeren", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Registreer", style: .default) { action in
                                        
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        Auth.auth().createUser(withEmail: emailField.text!,
                                                               password: passwordField.text!) { user, error in
                                                                if error == nil { Auth.auth().signIn(withEmail: self.userNameTextField.text!, password: self.passWordTextField.text!)
                                                                } else { let alert = UIAlertController(title:"Wachtwoord moet minstens 7 tekens zijn en de gebruikersnaam MOET een e-mail zijn!", message: "", preferredStyle: .alert)
                                                                    
                                                                    let cancelAction = UIAlertAction(title: "Sluit",
                                                                                                     style: .default)
                                                                    alert.addAction(cancelAction)
                                                                    self.present(alert, animated: true, completion: nil)
                                                                    
                                                                }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Sluit", style: .default)
        alert.addTextField { textEmail in textEmail.placeholder = "email adres" }
        alert.addTextField { textPassword in textPassword.isSecureTextEntry = true; textPassword.placeholder = "wachtwoord" }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
