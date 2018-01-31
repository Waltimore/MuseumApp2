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

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func savePressed(_ sender: Any) {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!)
        let childRef = ref.child("liked")
        let savedUser = childRef.child((collection.makeFirebaseString()))
        savedUser.setValue(searchedUser?.makeFirebaseString())
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("collection").child(collection.makeFirebaseString())
        if editingStyle == .delete && otherUser == false {
            let artWork = ref.child((self.userCollection[indexPath.row].title?.makeFirebaseString())!)
            artWork.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "collectionToDetail", sender: Any?.self)
    }
    
    var userCollection: [ArtObject] = []
    var collection: String!
    var artWork: ArtObject?
    var imageURL: String!
    var searchedUser: String?
    var otherUser: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "goudenBocht"))
        self.title = self.collection
        if otherUser == true {
            saveButton.isEnabled = true
            startObserving(user: searchedUser!)
        } else {
            startObserving(user: userID!)
            saveButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionToDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.collectionSegue = true
            detailViewController.collectionTitle = collection
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
        
        let ref = Database.database().reference(withPath: (user.makeFirebaseString())).child("collection").child(self.collection.makeFirebaseString())
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCollection.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCollectionCell", for: indexPath) as! ArtworkTableViewCell
        
        let title = NSAttributedString(string: userCollection[indexPath.row].title!, attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.strokeWidth : -1,
            ])
        let maker = NSAttributedString(string: userCollection[indexPath.row].principalMaker!, attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.strokeWidth : -1,
            ])
        
        cell.titleLabel.attributedText = title
        cell.makerLabel.attributedText = maker
        var userName: String!
        if otherUser == true {
            userName = searchedUser
        } else {
            userName = userID
        }
        let ref = Database.database().reference(withPath: (userName.makeFirebaseString())).child("collection").child(collection.makeFirebaseString()).child((userCollection[indexPath.row].title!.makeFirebaseString()))
            
            ref.observeSingleEvent(of: .value, with: { snapshot in
                
                if !snapshot.exists() { return }
                
                let imageURL = snapshot.childSnapshot(forPath: "imageURL").value as! String
                if imageURL != "Geen Afbeelding" {
                DispatchQueue.main.async {
                        let imgURL: NSURL = NSURL(string: (imageURL as String))!
                        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
                        NSURLConnection.sendAsynchronousRequest(
                            request as URLRequest, queue: OperationQueue.main,
                            completionHandler: {(response: URLResponse?,data: Data?,error: Error?) -> Void in
                                if error == nil {
                                    cell.artImage.image = UIImage(data: data!)
                                }
                        })
                }
                } else {
                    cell.artImage.image = UIImage(named: "geenAfb")
                }
            })
         return cell
        }

    }



