//
//  DetailViewController.swift
//  MuseumApp2
//
//  View controller that displays detailed information including a photo about artworks.
//
//  Created by David van der Velden on 12/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    var collectionSegue: Bool!
    var userID: String!
    var artWork: ArtObject!
    var imageURL: String!
    var collectionTitle: String!
    
    @IBAction func backToDetail(segue: UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.borderWidth = 2
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        // Disable buttons until all data is properly loaded
        createButton.isEnabled = false
        addButton.isEnabled = false
        // If Collection segue was performed, get image URL from Firebase database via getImage() function.
        if collectionSegue == true {
            getImage()
        }
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Gets image URL from the firebase database and loads the image into artImage.
    func getImage() {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("collection").child(collectionTitle.makeFirebaseString()).child((artWork.title?.makeFirebaseString())!)
    
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            let imageURL = snapshot.childSnapshot(forPath: "imageURL").value as! String
            self.imageURL = imageURL as String
            self.createButton.isEnabled = true
            self.addButton.isEnabled = true
            if imageURL != "Geen Afbeelding" {
                self.loadImage(urlString: imageURL as String)
            } else {
                self.artImage.image = UIImage(named: "geenAfb")
            }
        })
    }
    
    // Puts the information of the artWork into the text fields and image views.
    func updateUI() {
        if artWork != nil {
            nameLabel.text = artWork.title
            artistLabel.text = artWork.principalMaker
            if artWork.description != nil {
                descriptionTextView.text = artWork.description
            } else {
                descriptionTextView.text = "Dit kunstwerk heeft geen beschrijving."
            }
            if imageURL != nil {
                loadImage(urlString: imageURL)
            } else {
                self.artImage.image = UIImage(named: "geenAfb")
            }
            addButton.isEnabled = true
            createButton.isEnabled = true
        }
    }
    
    // Sends the app to the collections view controller where the user can pick in which collection he/she wants to store the artWork.
    @IBAction func addPressed(_ sender: Any) {
        performSegue(withIdentifier: "chooseCollection", sender: Any?.self)
    }
    
    // Opens a UIAlertController which allows user to create a new collection in the firebase database in which the current artWork will be saved.
    @IBAction func createPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Maak nieuwe collectie",
                                          message: "Maak nieuwe collectie",
                                          preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
                                        let collectionName = alert.textFields![0]
                                        let loggedUser = Auth.auth().currentUser?.email as String!
                                        let ref = Database.database().reference(withPath: (loggedUser!.makeFirebaseString()))
                                        let childRef = ref.child("collection")
                                        let childChildRef = childRef.child((collectionName.text?.makeFirebaseString())!)
                                        let savedArtwork = childChildRef.child((self.artWork.title?.makeFirebaseString())!)
                                        savedArtwork.setValue(self.artWork.toAnyObject())
                                        let URL = savedArtwork.child("imageURL")
                                        if self.imageURL != nil {
                                            URL.setValue(self.imageURL)
                                        } else { URL.setValue("Geen Afbeelding") }
                                        }

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { collectionName in
            collectionName.placeholder = "Naam van de collectie"
        }
            
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
            
        present(alert, animated: true, completion: nil)
    }
    
    // Uses the image URL to get the image and load it into the imageView.
    func loadImage(urlString:String)
    {
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        NSURLConnection.sendAsynchronousRequest(
            request as URLRequest, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse?,data: Data?,error: Error?) -> Void in
                if error == nil {
                    self.artImage.image = UIImage(data: data!)
                }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseCollection" {
            let collectionsTableViewController = segue.destination as! CollectionsTableViewController
            collectionsTableViewController.artWork = artWork
            collectionsTableViewController.imageURL = imageURL
            collectionsTableViewController.chooseCollection = true
        }
    }
}

