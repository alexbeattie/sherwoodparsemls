//
//  AboutSherwoodVC.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 6/18/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Parse

class AboutSherwoodVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var recentListings:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(TitleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = UIColor.white
        
        queryAllListings()

        collectionView?.reloadData()

    }


    var cellSelected : Int = 0
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected = indexPath.item
        var listingClass = PFObject(className: "AboutSherwoodVC")
        listingClass = recentListings[indexPath.row]

        let layout = UICollectionViewFlowLayout()
        let newDetailViewController = AboutSherwoodDetailVC(collectionViewLayout: layout)
        newDetailViewController.listing = listingClass

        navigationController?.pushViewController(newDetailViewController, animated: true)



            print("tapped")

    }

    func queryAllListings() {
        recentListings.removeAll()
        
        let query = PFQuery(className: "AboutSherwoodVC")
        
        query.order(byDescending: "price")
        query.cachePolicy = .networkElseCache
        
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects  {
                    for object in objects {
                        self.recentListings.append(object)
                         print(object)
                    }
                }
                self.collectionView?.reloadData()
                print(objects as Any)
            } else {
                print("alex")
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentListings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TitleCell
        var listingClass = PFObject(className: "AboutSherwoodVC")
        listingClass = recentListings[indexPath.row]

        DispatchQueue.main.async(execute: { () -> Void in

            let imageFile = listingClass["imageFile"] as? PFFile
            imageFile?.getDataInBackground { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        cell.image.image = UIImage(data: imageData)
                    }
                    //cell.activityIndicator.stopAnimating()
                }
            }
        })
        if let listingName = listingClass["title"] as? String {
            cell.nameLabel.text = listingName
        }
        
        if let listingPrice = listingClass["description"] as? String {
            cell.costLabel.text =  listingPrice
        }
        

        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 300)
//    }
    
    class TitleCell: BaseCell {
        var recentListings: PFObject? {
            didSet {
            }
        }
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "TEST"
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            return label
        }()
        let costLabel: UILabel = {
            let label = UILabel()
            label.text = "400"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            
            return label
        }()
        let viewContainer: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            return view
        }()
        let image: CustomImageView = {
            let iv = CustomImageView()
//            iv.image = UIImage(named:"pic")
            //        iv.backgroundColor = UIColor.black
            iv.contentMode = .scaleAspectFill
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.layer.masksToBounds = true
            return iv
        }()

        override func setupViews() {
            addSubview(image)

//            addSubview(viewContainer)
            addSubview(nameLabel)
            addSubview(costLabel)
//            addConstraintsWithFormat(format: "H:|[v0]|", views: viewContainer)
//            addConstraintsWithFormat(format: "V:|[v0]|", views: viewContainer)

//            addConstraintsWithFormat("H:|[v0]|", views: viewContainer)
//            addConstraintsWithFormat("V:|[v0(40)]|", views: viewContainer)
            
            addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
            addConstraintsWithFormat("V:|[v0]-8-|", views: nameLabel)
            
            addConstraintsWithFormat("H:|[v0]|", views: costLabel)
            addConstraintsWithFormat("V:[v0]-2-|", views: costLabel)
            
            addConstraintsWithFormat(format: "H:|[v0]|", views: image)
            addConstraintsWithFormat(format: "V:|[v0]|", views: image)

        }
    }
    let aboutCollectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
        
    }()

    
    
}
