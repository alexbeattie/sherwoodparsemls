//
//  SherwoodController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 6/26/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

//
//  ListingDetailController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Parse




class SherwoodController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    let descriptionId = "descriptionId"
    let headerId = "headerId"
    let titleId = "titleId"
    var recentListings:[PFObject] = []
    

  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setUpToolBarButtons()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "sherwood")
        imageView.image = image
        navigationItem.titleView = imageView
        
        collectionView?.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(NameCell.self, forCellWithReuseIdentifier: titleId)
        collectionView?.register(DetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionId)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.backgroundColor = UIColor.white
        
//        setupNavBarButtons()
        
        collectionView?.reloadData()
        queryAllListings()

        
    }
  
    func queryAllListings() {
        recentListings.removeAll()
        
        let query = PFQuery(className: "Sherwood")
        
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

    
//    func setupNavBarButtons() {
//        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleVideo))
//        moreButton.tintColor = UIColor.black
//        //        navigationItem.rightBarButtonItems = [moreButton]
//
//        let movieIcon = UIImage(named: "movie")?.withRenderingMode(.alwaysOriginal)
//        let videoButton = UIBarButtonItem(image: movieIcon, style: .plain, target: self, action: #selector(handleVideo))
//        navigationItem.rightBarButtonItems = [videoButton, moreButton]
//    }
    
    
//    @objc func addMe(sender: UIBarButtonItem) {
//        let textToShare = (listing?.StandardFields.UnparsedFirstLineAddress)
//        guard let site = NSURL(string: (listing?.StandardFields.Photos[0].Uri1024)!) else { return }
//        let objectsToShare = [textToShare, site] as [Any]
//        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//        activityVC.popoverPresentationController?.sourceView = sender as? UIView
//        activityVC.popoverPresentationController?.barButtonItem = sender
//        self.present(activityVC, animated: true, completion: nil)
//    }
    
  
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! NameCell
            var listingClass = PFObject(className: "Sherwood")
            listingClass = recentListings[indexPath.row]
            cell.nameLabel.text = listingClass["title"] as! String
            return cell
        }
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! DetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        var listingClass = PFObject(className: "Sherwood")
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

            return cell
        }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        
        
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: range)
        
//        if let desc = listing?.StandardFields.PublicRemarks {
//            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir Light", size: 16)!, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
//        }
        
        return attributedText
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentListings.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: 30)
        }
        if indexPath.item == 2 {
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 50)
        }
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
    
}


class DetailDescriptionCell: BaseCell {
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Avenir Light", size: 16)
        
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: dividerLineView)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
    }
}
