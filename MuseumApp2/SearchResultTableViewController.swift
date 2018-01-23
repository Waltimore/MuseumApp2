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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func artURL(objectnumber: String) -> String {
        let artURL = "https://www.rijksmuseum.nl/api/nl/collection/" + objectnumber + "?key=9A0wAsBM&format=json"
        return artURL
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow!.row
        let artWorkSelected = searchResults[index]
        let selectedURL = artURL(objectnumber: artWorkSelected.objectNumber!)
        retrieve(urlString: selectedURL)
    }
    
    
    var searchURL: String!
    var searchResults: [ArtObjects]!
    var artWork: ArtObject!
    var imageURL: String!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        if searchResults != nil {
        let title = self.searchResults[indexPath.row].title
        cell.textLabel?.text = title
        } else {
            cell.textLabel?.text = "Je zoek opdracht heeft geen resultaten opgeleverd!"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults == nil {
            return 1
        }
        return searchResults.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.artWork = artWork
            detailViewController.imageURL = imageURL
    }
}
}
