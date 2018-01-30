//
//  LikedUser.swift
//  MuseumApp2
//
//  Created by David van der Velden on 24/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import Foundation
import Firebase

struct LikedUser {
    let likedUser: String

    func toAnyObject() -> Any {
        return [ "likedUser": likedUser ]
    }
    
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: String]
//        let likedUser: String
//    }
}
