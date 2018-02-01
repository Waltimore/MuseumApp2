//
//  CollectionTableViewCell.swift
//  MuseumApp2
//
//  Cell used to display the names of collections.
//
//  Created by David van der Velden on 31/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var collectionTitleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
