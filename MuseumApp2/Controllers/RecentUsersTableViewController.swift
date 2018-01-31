//
//  RecentUsersTableViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 12/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class RecentUsersTableViewController: UITableViewController {

    var userID = Auth.auth().currentUser?.email as String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "goudenBocht"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    var likedCollections: [String] = []
    var likedCollection: String!
    var otherUsers: [String] = []
    var pressedUser: String!
    
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedCollections.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("liked").child(likedCollections[indexPath.row].makeFirebaseString())
        if editingStyle == .delete {
            ref.removeValue()
        }
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow!.row
        self.likedCollection = self.likedCollections[index]
        self.pressedUser = self.otherUsers[index]
        if likedCollections.count != 0 {
            performSegue(withIdentifier: "likedToCollection", sender: Any?.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likedToCollection" {
            let collectionTableViewController = segue.destination as! YourCollectionsTableViewController
            collectionTableViewController.otherUser = true
            collectionTableViewController.collection = self.likedCollection
            collectionTableViewController.searchedUser = self.pressedUser
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.likedCollections = []
        startObserving(user: userID!)
    }
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

