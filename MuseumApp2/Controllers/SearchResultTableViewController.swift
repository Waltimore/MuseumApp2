//
//  SearchResultTableViewController.swift
//  MuseumApp2
//
//  Table view controller showing the search results obtained via the Rijksmuseum API: https://www.rijksmuseum.nl/nl/api
//
//  Created by David van der Velden on 09/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class SearchResultTableViewController: UITableViewController {
    
    var userID = Auth.auth().currentUser?.email as String!
    var searchURL: String!
    var searchResults: [ArtObjects]!
    var artWork: ArtObject!
    var imageURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "goudenBocht"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 100 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults == nil {
            return 1
        }
        return searchResults.count
    }
    
    // Configures the cells by putting in the data obtained via retrieve() and sets the attributes for the text fields.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultTableViewCell
        if searchResults.count == 0 {
            cell.titleTextLabel.text = "Deze gebruiker bestaat niet of heeft nog geen collectie."
        } else {
            let title = NSAttributedString(string: searchResults[indexPath.row].title!, attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.strokeColor : UIColor.black,
                NSAttributedStringKey.strokeWidth : -1
                ])
            let maker = NSAttributedString(string: searchResults[indexPath.row].principalOrFirstMaker!, attributes: [
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.strokeColor : UIColor.black,
                NSAttributedStringKey.strokeWidth : -1
                ])
            cell.titleTextLabel.attributedText = title
            print(maker)
            cell.makerTextLabel.attributedText = maker
        }
        cell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow!.row
        let artWorkSelected = searchResults[index]
        let selectedURL = artURL(objectnumber: artWorkSelected.objectNumber!)
        retrieve(urlString: selectedURL)
    }
    
    // Obtainst data about the artwork via the API in a json format and puts this into the artWork struct and performs the segue to the Detail view controller.
    func retrieve(urlString: String) {
        let url = URL(string:urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            do {
                if let data = data {
                    let artWork = try jsonDecoder.decode(Json4Swift_Base.self, from: data)
                    self.imageURL = artWork.artObject?.webImage?.url
                    self.artWork = artWork.artObject
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "detailSegue", sender: Any?.self)
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // Creates the URL for the GET request.
    func artURL(objectnumber: String) -> String {
        let artURL = "https://www.rijksmuseum.nl/api/nl/collection/" + objectnumber + "?key=9A0wAsBM&format=json"
        return artURL
    }
    
    // Passes the information to the Detail view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.artWork = artWork
            detailViewController.userID = userID
            detailViewController.imageURL = imageURL
        }
    }
}
