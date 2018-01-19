//
//  StringExtension.swift
//  MuseumApp2
//
//  Created by David van der Velden on 17/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import Foundation

extension String {
    func makeFirebaseString()->String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = self
        
        for character in arrCharacterToReplace{
            finalString = finalString.replacingOccurrences(of: character, with: " ")
        }
        
        return finalString
    }
}
