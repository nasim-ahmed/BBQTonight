//
//  OfferVC.swift
//  bbqtonight
//
//  Created by Nasim on 4/17/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase


class OfferVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var refOffers: DatabaseReference!
    
    
    var offersArray = [Offer]()
    
    private let cellID = "cellId"
    
    let imageView: UIImageView = {
        let iv = UIImageView ()
        iv.image = #imageLiteral(resourceName: "menu-1")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    

    let blackView: UIVisualEffectView = {
        let bv = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        bv.alpha = 0.7
        return bv
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9294117647, blue: 0.9490196078, alpha: 1)
        
        // get the navigation bar from the current navigation controller if there is one
        let navBar = self.navigationController?.navigationBar
        
        // change the bar tint color to change what the color of the bar itself looks like
        navBar?.barTintColor = UIColor.black
        
        // tint color changes the color of the nav item colors eg. the back button
        navBar?.tintColor = UIColor.white
        
        // if you notice that your nav bar color is off by a bit, sometimes you will have to
        // change it to not translucent to get correct color
        navBar?.isTranslucent = false
        
        // the following attribute changes the title color
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationItem.title = "Offers"
        
        collectionView.register(OfferCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAllOffers()
    }
    
    func fetchAllOffers(){
        refOffers = Database.database().reference().child("Offers")
        
        refOffers.observeSingleEvent(of: .value) { (snapshot) in
            self.offersArray.removeAll()
            
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            
            dictionaries.forEach({ (key, value) in
                
                guard let offerDictionary = value as? [String: Any] else {return}
                
                let offer = Offer(offerId: key, dictionary: offerDictionary)
                self.offersArray.append(offer)
            })
            
            self.collectionView.reloadData()
            
        }
    }
    
    func setUpViews(){
//        view.addSubview(imageView)
//        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
//
//        imageView.addSubview(blackView)
//        blackView.anchor(top: navigationController?.navigationBar.bottomAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offersArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OfferCell
        
        let offerItem = offersArray[indexPath.item]
        
        cell.offer = offerItem
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.6)
    }
    
    
    
    
}
