//
//  SoldListingsVC.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 6/24/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Parse

class SherwoodVC : UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let sherwoodId = "sherwoodId"
    let imageId = "imageId"
    let nameId = "nameId"
    
    var recentListings:[PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(TitleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(SoldListingsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView?.register(SherwoodCell.self, forCellWithReuseIdentifier: "sherwoodId")
        collectionView?.register(ImageCell.self, forCellWithReuseIdentifier: "imageId")
        collectionView?.register(NameCell.self, forCellWithReuseIdentifier: "nameId")
        
        queryAllListings()
        collectionView?.reloadData()

    }
    var cellSelected : Int = 0
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected = indexPath.item
        var listingClass = PFObject(className: "Sherwood")
        //listingClass = recentListings[indexPath.row]
        
        //let layout = UICollectionViewFlowLayout()
        //let newDetailViewController = AboutSherwoodDetailVC(collectionViewLayout: layout)
        //newDetailViewController.listing = listingClass
        
        //navigationController?.pushViewController(newDetailViewController, animated: true)
        
        
        
        print("tapped")
        
    }
    func queryAllListings() {
        recentListings.removeAll()
        
        let query = PFQuery(className: "Sherwood")
        
        //query.order(byDescending: "price")
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentListings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sherwoodId, for: indexPath) as! SherwoodCell
        cell.backgroundColor = UIColor.purple
        var listingClass = PFObject(className: "Sherwood")
        listingClass = recentListings[indexPath.row]
        
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageId, for: indexPath) as! ImageCell
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

            
            
            return cell
        }
//        if indexPath.item == 2 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! N
//            cell.textView.attributedText = descriptionAttributedText()
//            return cell
//        }
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nameId, for: indexPath) as! NameCell
                    if let listingName = listingClass["title"] as? String {
                        cell.nameLabel.text = listingName
                    }
            return cell
        }
//        if let listingName = listingClass["title"] as? String {
//            cell.nameLabel.text = listingName
//        }
//
//        if let listingPrice = listingClass["description"] as? String {
//            cell.costLabel.text =  listingPrice
//        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = (view.frame.width)
        return CGSize(width: view.frame.width, height: 200)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 300)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! SoldListingsHeader
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    


    
   
}
