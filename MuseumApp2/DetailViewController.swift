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
        let ref = Database.database().reference(withPath: userID.makeFirebaseString())
        let childRef = ref.child("collection")
        let savedArtwork = childRef.child((artWork.title?.makeFirebaseString())!)
        savedArtwork.setValue(artWork.toAnyObject())
        let URL = savedArtwork.child("imageURL")
        URL.setValue(imageURL)
    }
    
    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var artWork: ArtObject!
    var imageURL: String!
    
    func getImage() {
        let ref = Database.database().reference(withPath: userID.makeFirebaseString()).child("collection").child((artWork.title?.makeFirebaseString())!)
    
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

