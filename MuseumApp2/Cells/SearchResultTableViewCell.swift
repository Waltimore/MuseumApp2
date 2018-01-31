//
//  SearchResultTableViewCell.swift
//  MuseumApp2
//
//  Created by David van der Velden on 26/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var makerTextLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
