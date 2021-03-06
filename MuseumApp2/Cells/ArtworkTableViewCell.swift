//
//  ArtworkTableViewCell.swift
//  MuseumApp2
//
//  Cell used to display Artworks in the collection view controller.
//
//  Created by David van der Velden on 30/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit

class ArtworkTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var artImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
