//
//  YourCollectionsTableViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 12/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class YourCollectionsTableViewController: UITableViewController {

    var userID = Auth.auth().currentUser?.email as String!

    @IBAction func signOutPressed(_ sender: Any) {
        do { try Auth.auth().signOut() } catch { print(error) }
        if Auth.auth().currentUser != nil {
            // User is signed in.
            print("user is signed in")
        } else {
            print("not logged in")
            performSegue(withIdentifier: "logOut", sender: Any?.self)
            // No user is signed in.
        }
    }
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func savePressed(_ sender: Any) {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!)
        let childRef = ref.child("liked")
        let savedUser = childRef.child((searchedUser?.makeFirebaseString())!)
        savedUser.setValue(searchedUser?.makeFirebaseString())
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("collection")
        if editingStyle == .delete {
            let artWork = ref.child((self.userCollection[indexPath.row].title?.makeFirebaseString())!)
            artWork.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "collectionToDetail", sender: Any?.self)
    }
    
    var userCollection: [ArtObject] = []
    var otherUser: Bool = false
    var searchedUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if otherUser == true {
            startObserving(user: searchedUser!)
            saveButton.isEnabled = true
        } else {
        saveButton.isEnabled = false
        startObserving(user: userID!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionToDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.collectionSegue = true
            if otherUser == true {
                detailViewController.userID = searchedUser
            } else {
                detailViewController.userID = userID
            }
            let index = tableView.indexPathForSelectedRow!.row
            detailViewController.artWork = self.userCollection[index]
        }
    }
    
    func startObserving(user: String) {
        
        let ref = Database.database().reference(withPath: (user.makeFirebaseString())).child("collection")
        ref.observe(.value, with: { snapshot in
        
        var collectionArt: [ArtObject] = []
        
        
        for item in snapshot.children {
        let artWork = ArtObject(snapshot: item as! DataSnapshot)
        collectionArt.append(artWork)
        }
        self.userCollection = collectionArt
        self.tableView.reloadData()
        })
        
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        if userCollection.count == 0 && otherUser == true {
        cell.textLabel?.text = "Deze gebruiker bestaat niet of heeft nog geen collectie."
        } else {
            let artTitle = self.userCollection[indexPath.row].title
            cell.textLabel?.text = artTitle
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userCollection.count == 0 && otherUser == true {
            return 1
        }
        return userCollection.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCollectionCell", for: indexPath)

        configure(cell: cell, forItemAt: indexPath)

        return cell
    }

}



