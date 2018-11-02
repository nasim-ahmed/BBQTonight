//
//  HomeCell.swift
//  Shajuni
//
//  Created by SOUMEN GHOSH on 23/2/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    
    var imagesArray = [#imageLiteral(resourceName: "chicken"), #imageLiteral(resourceName: "chicken sizzling"), #imageLiteral(resourceName: "burgur101"), #imageLiteral(resourceName: "gourmet steak"), #imageLiteral(resourceName: "lamb")]
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red:0.94, green:0.31, blue:0.46, alpha:1.0)
        pc.numberOfPages = self.imagesArray.count
        pc.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        return pc
    }()
    
    let bottomView: UIView = {
        let tv = UIView()
        tv.backgroundColor = .black
        tv.alpha = 0.7
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

  
    
    @objc func pageControlChanged(){
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / frame.width)
        pageControl.currentPage = pageNumber
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        setup()
    }
    
    
    
    let featuredCollectionView: AutoScrollingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = AutoScrollingCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.scrollInterval = 2
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cv.backgroundColor = .red
        return cv
    }()
    let featuredLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Popular Dishes"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.font = UIFont(name: "Helvetica-Bold", size: 24)
        tv.numberOfLines = 0
//        tv.backgroundColor = .blue
        return tv
    }()
    

    
    func setup() {
        featuredCollectionView.backgroundColor = .white
        featuredCollectionView.register(ItemCell.self,  forCellWithReuseIdentifier: cellID)
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        
        addSubview(featuredCollectionView)
        featuredCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        self.featuredCollectionView.startScrolling()
        
        
//        featuredCollectionView.addSubview(pageControl)
//        pageControl.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        addSubview(bottomView)
        bottomView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 80)
        
        addSubview(featuredLabel)
        featuredLabel.anchor(top: bottomView.topAnchor, left: bottomView.leftAnchor, bottom: bottomView.bottomAnchor, right: bottomView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ItemCell
        cell.imageView.image = imagesArray[indexPath.row]
        
        
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}



class ItemCell: UICollectionViewCell {
    

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








