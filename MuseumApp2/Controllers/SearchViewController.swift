//
//  SearchViewController.swift
//  MuseumApp2
//
//  View controller in which users can search the collection of the Rijksmuseum via the API.
//
//  Created by David van der Velden on 09/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var imageURL: String?
    var searchResults: [ArtObjects]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Hides keyboard when background pressed.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Get info from searchTextField and create a search URL GET request from this.
    @IBAction func searchPressed(_ sender: Any) {
        let userSearchInput = searchTextField.text
        let searchURL = Search(query: userSearchInput!)
        retrieve(urlString: searchURL)
    }
    
    // Create a usable URL from the search query.
    func Search(query: String) -> String {
        let trimmedQuery = query.replacingOccurrences(of: " ", with: "%")
        let searchURL = "https://www.rijksmuseum.nl/api/nl/collection?q=" + trimmedQuery + "&key=9A0wAsBM&format=json"
        print(searchURL)
        return searchURL
    }

    // Retrieve the search results via the API, put these in the searchResults array and perform segue to the Search Results view controller.
    func retrieve(urlString: String) {
        
        let urlPath = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string:urlPath!)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            do {
                if let data = data {
                let artWorks = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = artWorks.artObjects
                    
                    DispatchQueue.main.async { self.performSegue(withIdentifier: "searchSegue", sender: Any?.self) }
                }
            } catch { print(error) }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            let searchResultTableViewController = segue.destination as! SearchResultTableViewController
            searchResultTableViewController.searchResults = searchResults
        }
    }
}
