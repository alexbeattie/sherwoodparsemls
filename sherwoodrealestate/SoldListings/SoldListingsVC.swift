//
//  SoldListingsVC.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 6/24/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit

class SoldListingsVC : UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(TitleCell.self, forCellWithReuseIdentifier: cellId)

        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(SoldListingsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")

        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TitleCell
        cell.backgroundColor = UIColor.purple
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 4
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 300)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! SoldListingsHeader
        

        //not correct
        //header.addSubview(UIImageView())
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    


    
//    class TitleCell: BaseCell {
//        var listing: Listing.listingResults? {
//            didSet {
//
//                if let theAddress = listing?.StandardFields.UnparsedAddress {
//
//                    nameLabel.text = theAddress
//                }
//
//                if let listPrice = listing?.StandardFields.ListPrice{
//                    let nf = NumberFormatter()
//                    nf.numberStyle = .decimal
//                    let subTitleCost = "$\(nf.string(from: NSNumber(value:(UInt64(listPrice))))!)"
//                    costLabel.text = subTitleCost
//                }
//            }
//        }
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
//        let viewContainer: UIView = {
//            let view = UIView()
//            view.backgroundColor = UIColor.clear
//            return view
//        }()
//
//        override func setupViews() {
//
//            addSubview(viewContainer)
//            addSubview(nameLabel)
//            addSubview(costLabel)
//            addConstraintsWithFormat(format: "H:|[v0]|", views: viewContainer)
//            addConstraintsWithFormat(format: "V:|[v0]|", views: viewContainer)
//
//
//            addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
//            addConstraintsWithFormat("V:|[v0]-8-|", views: nameLabel)
//
//            addConstraintsWithFormat("H:|[v0]|", views: costLabel)
//            addConstraintsWithFormat("V:|-22-[v0]", views: costLabel)
//
//        }
//    }
//    let aboutCollectionView:UICollectionView = {
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        
//        return collectionView
//        
//    }()
//}
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//    return CGSize(width: view.frame.width, height: 200)
//}
//
//
//
//struct User {
//    let username: String
//    let profileImageUrl: String
//    
//    init(dictionary: [String: Any]) {
//        self.username = dictionary["username"] as? String ?? ""
//        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
//    }
//}
//
//
}
