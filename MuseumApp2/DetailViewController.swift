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
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    let userID = Auth.auth().currentUser?.email as! String
    
    @IBAction func addPressed(_ sender: Any) {
            print(userID)

        let ref = Database.database().reference(withPath: userID.makeFirebaseString())
        let childRef = ref.child("collection")
        let savedArtwork = childRef.child((artWork.title?.makeFirebaseString())!)
        savedArtwork.setValue(artWork.toAnyObject())
    }
    
    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var artWork: ArtObject!
    var imageURL: String!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        if artWork != nil {
            nameLabel.text = artWork.title
            artistLabel.text = artWork.principalMaker
            descriptionLabel.text = artWork.description
            if imageURL != nil {
                load_image(urlString: imageURL)
            }
        }
    }
    
    func load_image(urlString:String)
    {
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        NSURLConnection.sendAsynchronousRequest(
            request as URLRequest, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse?,data: Data?,error: Error?) -> Void in
                if error == nil {
                    self.artImage.image = UIImage(data: data!)
                }
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

