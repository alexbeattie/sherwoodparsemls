//
//  AboutSherwoodDetailVC.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 6/25/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Parse
import MapKit

class AboutSherwoodDetailVC: UICollectionViewController, MKMapViewDelegate  {
    let cellId = "cellId"

    var listingClass = PFObject(className: "AboutSherwoodVC")

    var listing = PFObject(className: "AboutSherwoodVC") {
        didSet {
            
            print(listing)
            print(listing["title"])
            print(listing["description"])
            
//            if listing?.StandardFields.Photos != nil {
//                return
//            }
//            if listing?.StandardFields.VirtualTours != nil {
//                return
//            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.backgroundColor = UIColor.purple
//        setupViews()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
}
    class MainCell: UICollectionViewCell {
        var recentListings: PFObject? {
            didSet {
            }
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
//            setupViews()
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
//
//        let nameLabel: UILabel = {
//            let label = UILabel()
//            label.text = "TEST"
//            label.font = UIFont.systemFont(ofSize: 16)
//            label.textAlignment = .center
//            return label
//        }()
//        let costLabel: UILabel = {
//            let label = UILabel()
//            label.text = "400"
//            label.font = UIFont.systemFont(ofSize: 12)
//            label.textColor = UIColor.darkGray
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.textAlignment = .center
//
//            return label
//        }()
//        let image: CustomImageView = {
//            let iv = CustomImageView()
//            iv.contentMode = .scaleAspectFill
//            iv.translatesAutoresizingMaskIntoConstraints = false
//            iv.layer.masksToBounds = true
//            return iv
//        }()
//        func setupViews() {
//           // addSubview(image)
//
//            addSubview(nameLabel)
//            addSubview(costLabel)
//
//            addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
//            addConstraintsWithFormat("V:|[v0]-8-|", views: nameLabel)
//
//            addConstraintsWithFormat("H:|[v0]|", views: costLabel)
//            addConstraintsWithFormat("V:[v0]-2-|", views: costLabel)
//
//            addConstraintsWithFormat(format: "H:|[v0]|", views: image)
//            addConstraintsWithFormat(format: "V:|[v0]|", views: image)
//
//        }
    }
