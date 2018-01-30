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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if otherUser == true {
            startObserving(user: searchedUser!)
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
            startObserving(user: userID!)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath)
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        if collections.count == 0 {
            cell.textLabel?.text = "Deze gebruiker bestaat niet of heeft nog geen collectie."
        } else {
            cell.textLabel?.text = collections[indexPath.row]
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
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if chooseCollection == false {
            performSegue(withIdentifier: "collectionToArt", sender: Any?.self)
        } else {
            let index = tableView.indexPathForSelectedRow!.row
            let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!)
            let childRef = ref.child("collection").child(collections[index].makeFirebaseString())
            let savedArtwork = childRef.child((artWork.title?.makeFirebaseString())!)
            savedArtwork.setValue(artWork.toAnyObject())
            let URL = savedArtwork.child("imageURL")
            URL.setValue(imageURL)
            performSegue(withIdentifier: "backToDetail", sender: Any?.self)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collections = []
        if otherUser == false {
        startObserving(user: userID!)
        } else {
            startObserving(user: searchedUser!)
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
