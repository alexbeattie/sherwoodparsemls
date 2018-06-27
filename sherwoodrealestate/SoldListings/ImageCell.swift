//
//  ImageCell.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 6/26/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Parse

class ImageCell : BaseCell {
    var recentListings: PFObject? {
        didSet {
        }
    }
    let image: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        return iv
    }()
    override func setupViews() {
        super.setupViews()
        
        addSubview(image)
        addConstraintsWithFormat(format: "H:|[v0]|", views: image)
        addConstraintsWithFormat(format: "V:|[v0]|", views: image)
        
    }
}
