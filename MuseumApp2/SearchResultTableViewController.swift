//
//  SearchResultTableViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 09/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {

    func retrieve(urlString: String) {
        let url = URL(string:urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //print(error as Any)
            do {
                if let data = data {
                    let artWork = try jsonDecoder.decode(Json4Swift_Base.self, from: data)
                    self.imageURL = artWork.artObject?.webImage?.url
                    self.artWork = artWork.artObject
                    print(artWork)
                    print(self.artWork)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //retrieve(urlString:"https://www.rijksmuseum.nl/api/en/collection/SK-A-469?key=9A0wAsBM&format=json")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
//        if self.artWork != nil {
//            performSegue(withIdentifier: "DetailSegue", sender: Any?.self)
//        }
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func artURL(objectnumber: String) -> String {
        var artURL = "https://www.rijksmuseum.nl/api/en/collection/" + objectnumber + "?key=9A0wAsBM&format=json"
        return artURL
    }
    
    var searchResults: [ArtObjects]!
    var artWork: ArtObject!
    var imageURL: String!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let title = self.searchResults[indexPath.row].title
        cell.textLabel?.text = title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchResults.count == 0 {
            return 1
        }
        return searchResults.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let detailViewController = segue.destination as! DetailViewController
            print(artWork)
            detailViewController.artWork = artWork
            detailViewController.imageURL = imageURL
            var index = tableView.indexPathForSelectedRow!.row
            var artWorkSelected = searchResults[index]
            var selectedURL = artURL(objectnumber: artWorkSelected.objectNumber!)
            retrieve(urlString: selectedURL)
    }
}
}
