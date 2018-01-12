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
    let principalMaker: String
    
    init(title: String, principalMaker: String) {
        self.title = title
        self.principalMaker = principalMaker
    }
}
