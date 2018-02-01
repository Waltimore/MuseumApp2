//
//  RecentUsersTableViewController.swift
//  MuseumApp2
//
//  Table view controller in which the "likes" (collections of other users) of the logged in user are displayed.
//
//  Created by David van der Velden on 12/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class RecentUsersTableViewController: UITableViewController {

    var userID = Auth.auth().currentUser?.email as String!
    var likedCollections: [String] = []
    var likedCollection: String!
    var otherUsers: [String] = []
    var pressedUser: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "goudenBocht"))
    }
    
    // Everytime the view controller is revisited, synchronize with the firebase database.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.likedCollections = []
        startObserving(user: userID!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Put information obtained from firebase into the cell and set attributes.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedUserCell", for: indexPath) as! CollectionTableViewCell
        if likedCollections.count == 0 {
            cell.collectionTitleLabel.text = "Deze gebruiker bestaat niet of heeft nog geen collectie."
        } else {
            let titleString = NSAttributedString(string: likedCollections[indexPath.row], attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.strokeColor : UIColor.black,
                NSAttributedStringKey.strokeWidth : -1
                ])
            cell.collectionTitleLabel.attributedText = titleString
        }
        cell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedCollections.count
    }
    
    // Allow users to delete their likes and resynchronize the tableview after.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("liked").child(likedCollections[indexPath.row].makeFirebaseString())
        if editingStyle == .delete { ref.removeValue() }
        super.viewDidAppear(true)
        self.likedCollections = []
        startObserving(user: userID!)
    }
    
    // If a cell is pressed, move and pass information to the Collection view controller.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow!.row
        self.likedCollection = self.likedCollections[index]
        self.pressedUser = self.otherUsers[index]
        if likedCollections.count != 0 {
            performSegue(withIdentifier: "likedToCollection", sender: Any?.self)
        }
    }

    // Obtain "liked" data from logged in user from the firebase database.
    func startObserving(user: String) {
        
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("liked")
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
           
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                let otherUser = snap.value
                self.likedCollections.append(key)
                self.otherUsers.append(otherUser as! String)
            }
            self.tableView.reloadData()
        })
    }
    
    // Set data in Collection view controller so the correct collection is displayed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likedToCollection" {
            let collectionTableViewController = segue.destination as! CollectionInfoTableViewController
            collectionTableViewController.otherUser = true
            collectionTableViewController.collection = self.likedCollection
            collectionTableViewController.searchedUser = self.pressedUser
        }
    }
}

