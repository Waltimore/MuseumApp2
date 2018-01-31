//
//  SearchUsersViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 22/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class SearchUsersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        do { try Auth.auth().signOut() } catch { print(error) }
        if Auth.auth().currentUser == nil {
            performSegue(withIdentifier: "logOut", sender: Any?.self)
        }
    }

    @IBOutlet weak var searchTextField: UITextField!
    
    var userID: String?
    
    @IBAction func zoekPressed(_ sender: UIButton) {
        self.userID = searchTextField.text
        performSegue(withIdentifier: "userSearched", sender: Any?.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userSearched" {
            let collectionTableViewController = segue.destination as! CollectionTableViewController
            collectionTableViewController.otherUser = true
            collectionTableViewController.searchedUser = userID
        }
    }
}
