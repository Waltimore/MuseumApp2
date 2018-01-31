//
//  BlurTabBar.swift
//  MuseumApp2
//
//  Created by David van der Velden on 31/01/2018.
//  Copyright © 2018 David van der Velden. All rights reserved.
//

import UIKit

class BlurTabBar: UITabBar {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        frost.frame = bounds
        frost.autoresizingMask = .flexibleWidth
        insertSubview(frost, at: 0)
    }
}
