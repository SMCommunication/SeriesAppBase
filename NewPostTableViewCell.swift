//
//  NewPostTableViewCell.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/17/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

import UIKit
import Bond

class NewPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        
        bnd_bag.dispose()
    }
}
