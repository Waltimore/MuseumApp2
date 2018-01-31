//
//  CollectionTableViewCell.swift
//  MuseumApp2
//
//  Created by David van der Velden on 31/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var collectionTitleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
