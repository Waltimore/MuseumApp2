//
//  SearchViewController.swift
//  MuseumApp2
//
//  Created by David van der Velden on 09/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //updateUI()
        // Do any additional setup after loading the view.

    }
    @IBAction func searchPressed(_ sender: Any) {
        var userSearchInput = searchTextField.text
        var searchURL = Search(query: userSearchInput!)
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
                    //print(artWorks)
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
        var searchURL = "https://www.rijksmuseum.nl/api/nl/collection?q=" + query + "&key=9A0wAsBM&format=json"
        return searchURL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    func updateUI() {
        searchResultLabel.text = (self.artWork?.title as! String)
    }
    
}
