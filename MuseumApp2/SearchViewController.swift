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
        retrieve()
        updateUI()
    }
    
    var artWork: ArtWork!
    
    func retrieve() {
        let url = URL(string:"https://www.rijksmuseum.nl/api/en/collection/SK-A-4691?key=9A0wAsBM&format=json")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            print(data!)
            print(error as Any)
            if let data = data,
                let artWork = try? jsonDecoder.decode(ArtWork.self, from: data) {
                print(artWork)
                self.artWork = artWork
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    func updateUI() {
        //searchResultLabel.text = artWork.title
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
