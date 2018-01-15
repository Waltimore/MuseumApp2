//
//  Artwork.swift
//  MuseumApp2
//
//  Created by David van der Velden on 09/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import Foundation

struct ArtWork: Codable {
    
    
    let title: String
    let description: String
    let makerLine: String
    
    enum SerializationError:Error {
        case missing(String)
        case invalid (String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let title = json["title"] as? String  else {throw SerializationError.missing("title missing")}
        
        guard let description = json["description"] as? String else {throw SerializationError.missing("descript missing")}
        
        guard let makerLine = json["makerLine"] as? String else {throw SerializationError.missing("makerline missing")}
        
        self.title = title
        self.description = description
        self.makerLine = makerLine
    }
    
    static let url = "https://www.rijksmuseum.nl/api/en/collection/SK-A-4691?key=9A0wAsBM&format=json"
    
    static func getArt (completion: @escaping (ArtWork) -> ()) {
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response: URLResponse?, error:Error?) in
            
            var artWork: ArtWork
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let label = json["label"] as? [String:Any] {
                            if let artInfo = try? ArtWork(json: label) {
                                artWork = artInfo
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        
        task.resume()
    }

}
