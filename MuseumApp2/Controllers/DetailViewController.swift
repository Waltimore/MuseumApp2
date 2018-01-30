//
//  DetailViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 12/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if collectionSegue == true {
            getImage()
        }
        updateUI()
    }
    
    var collectionSegue: Bool!
    var userID: String!
    
    @IBAction func addPressed(_ sender: Any) {
        performSegue(withIdentifier: "chooseCollection", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseCollection" {
            let CollectionTableViewController = segue.destination as! CollectionTableViewController
            CollectionTableViewController.artWork = artWork
            CollectionTableViewController.imageURL = imageURL
            CollectionTableViewController.chooseCollection = true
        }
    }

    @IBAction func backToDetail(segue: UIStoryboardSegue) { }
    
    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var artWork: ArtObject!
    var imageURL: String!
    var collectionTitle: String!
    
    func getImage() {
        let ref = Database.database().reference(withPath: (userID?.makeFirebaseString())!).child("collection").child(collectionTitle.makeFirebaseString()).child((artWork.title?.makeFirebaseString())!)
    
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot) 
            
            let imageURL = snapshot.childSnapshot(forPath: "imageURL").value
            if imageURL != nil {
                self.load_image(urlString: imageURL as! String)
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
        if artWork != nil {
            nameLabel.text = artWork.title
            artistLabel.text = artWork.principalMaker
            descriptionTextView.text = artWork.description
            if imageURL != nil {
                load_image(urlString: imageURL)
            }
        }
    }
    
    
    @IBAction func createPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Maak nieuwe collectie",
                                          message: "Maak nieuwe collectie",
                                          preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
                                        let collectionName = alert.textFields![0]
                                        
                                        let ref = Database.database().reference(withPath: (self.userID?.makeFirebaseString())!)
                                        let childRef = ref.child("collection")
                                        let childChildRef = childRef.child((collectionName.text?.makeFirebaseString())!)
                                        let savedArtwork = childChildRef.child((self.artWork.title?.makeFirebaseString())!)
                                        savedArtwork.setValue(self.artWork.toAnyObject())
                                        let URL = savedArtwork.child("imageURL")
                                        URL.setValue(self.imageURL)
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
    

    
    func load_image(urlString:String)
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
}

