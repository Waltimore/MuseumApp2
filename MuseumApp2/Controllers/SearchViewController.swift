//
//  SearchViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 09/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class SearchViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func searchPressed(_ sender: Any) {
        let userSearchInput = searchTextField.text
        let searchURL = Search(query: userSearchInput!)
        retrieve(urlString: searchURL)
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    var artWork: Label!
    var imageURL: String?
    var searchResults: [ArtObjects]!
    
    func retrieve(urlString: String) {
        let url = URL(string:urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            do {
                if let data = data {
                let artWorks = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = artWorks.artObjects
                    
                    DispatchQueue.main.async {
                         self.performSegue(withIdentifier: "searchSegue", sender: Any?.self)
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            let searchResultTableViewController = segue.destination as! SearchResultTableViewController
            searchResultTableViewController.searchResults = searchResults
        }
    }
    
    func Search(query: String) -> String {
        let trimmedQuery = query.replacingOccurrences(of: " ", with: "%")
        let searchURL = "https://www.rijksmuseum.nl/api/nl/collection?q=" + trimmedQuery + "&key=9A0wAsBM&format=json"
        print(searchURL)
        return searchURL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
