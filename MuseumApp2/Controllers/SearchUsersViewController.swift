//
//  SearchUsersViewController.swift
//  MuseumApp2
//
//  View controller in which a user can search for other users (by their e-mail) and see their collections.
//
//  Created by David van der Velden on 22/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class SearchUsersViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Hides keyboard when background pressed.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // App goes to the collections view controller, passing data about the searched user.
    @IBAction func zoekPressed(_ sender: UIButton) {
        self.userID = searchTextField.text
        performSegue(withIdentifier: "userSearched", sender: Any?.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userSearched" {
            let collectionTableViewController = segue.destination as! CollectionsTableViewController
            collectionTableViewController.otherUser = true
            collectionTableViewController.searchedUser = userID
        }
    }
}
