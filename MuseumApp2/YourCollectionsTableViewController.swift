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

    let ref = Database.database().reference(withPath: "gekkehenk@hotmail com").child("collection")
    
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
    
    var userCollection: [ArtObject] = []
    
    //var artWork: [Artwork]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObserving()        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collection2detail" {
            let detailViewController = segue.destination as! DetailViewController
            //print(artWork)
            var index = tableView.indexPathForSelectedRow!.row
            detailViewController.artWork = self.userCollection[index]
            //detailViewController.imageURL = imageURL            
            //var artWorkSelected = searchResults[index]
            //var selectedURL = artURL(objectnumber: artWorkSelected.objectNumber!)
            //retrieve(urlString: selectedURL)
        }
    }
    
    func startObserving() {
        //var collectionRef = ref.child("collection")
        ref.observe(.value, with: { snapshot in
        
        var collectionArt: [ArtObject] = []
        
        print(snapshot.children)
            
        for item in snapshot.children {
        let artWork = ArtObject(snapshot: item as! DataSnapshot)
        collectionArt.append(artWork)
        }
        
        self.userCollection = collectionArt
        self.tableView.reloadData()
        
        })
    }
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let artTitle = self.userCollection[indexPath.row].title
        cell.textLabel?.text = artTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userCollection.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCollectionCell", for: indexPath)

        configure(cell: cell, forItemAt: indexPath)// Configure the cell...

        return cell
    }

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



