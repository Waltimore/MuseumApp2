//
//  CollectionTableViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 29/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class CollectionTableViewController: UITableViewController {
    
    var userID = Auth.auth().currentUser?.email as String!

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    
    @IBAction func signOutPressed(_ sender: Any) {
        do { try Auth.auth().signOut() } catch { print(error) }
        if Auth.auth().currentUser == nil {
            performSegue(withIdentifier: "logOut", sender: Any?.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isEnabled = false
        backButton.tintColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "goudenBocht"))
        if chooseCollection == true {
            signOutButton.isEnabled = false
            signOutButton.tintColor = UIColor.clear
            backButton.isEnabled = true
            backButton.tintColor = UIColor.black
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! CollectionTableViewCell
        if collections.count == 0 {
            cell.collectionTitleLabel.text = "Deze gebruiker bestaat niet of heeft nog geen collectie."
        } else {
            let title = NSAttributedString(string: collections[indexPath.row], attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.strokeColor : UIColor.black,
                NSAttributedStringKey.strokeWidth : -1
                ])
            cell.collectionTitleLabel.attributedText = title
        }
        cell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("collection").child(collections[indexPath.row].makeFirebaseString())
        if editingStyle == .delete && otherUser == false {
            ref.removeValue()
        }
        self.collections = []
        if otherUser == false {
            startObserving(user: userID!)
        } else {
            startObserving(user: searchedUser!)
        }
    }
    
    var collections: [String] = []
    var artWork: ArtObject!
    var imageURL: String!
    var otherUser: Bool = false
    
    var searchedUser: String?
    var chooseCollection: Bool = false
    
    func startObserving(user: String) {
        
        let ref = Database.database().reference(withPath: (user.makeFirebaseString())).child("collection")
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.collections.append(key)
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if chooseCollection == false {
            if collections.count != 0 {
            self.performSegue(withIdentifier: "collectionToArt", sender: Any?.self)
            }
        } else {
            let index = tableView.indexPathForSelectedRow!.row
            let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!)
            let childRef = ref.child("collection").child(collections[index].makeFirebaseString())
            let savedArtwork = childRef.child((artWork.title?.makeFirebaseString())!)
            savedArtwork.setValue(artWork.toAnyObject())
            let URL = savedArtwork.child("imageURL")
            if self.imageURL != nil {
                URL.setValue(self.imageURL)
            } else { URL.setValue("Geen Afbeelding") }
            if collections.count != 0 {
                self.performSegue(withIdentifier: "backToDetail", sender: Any?.self)
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionToArt" {
            let yourCollectionsTableViewController = segue.destination as! YourCollectionsTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            yourCollectionsTableViewController.collection = collections[index]
            if otherUser == true {
                yourCollectionsTableViewController.otherUser = true
                yourCollectionsTableViewController.searchedUser = searchedUser
            }
        }
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if otherUser == false {
            return .delete
        } else {
            return .none
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collections = []
        if otherUser == false {
            startObserving(user: userID!)
        } else {
            startObserving(user: searchedUser!)
        }
    }
}
