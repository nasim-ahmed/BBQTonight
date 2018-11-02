//
//  OfferCell.swift
//  bbqtonight
//
//  Created by Nasim on 4/17/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

class OfferCell: UICollectionViewCell {
    
    var offer: Offer?{
        didSet{
            guard let url = offer?.imageUrl else {
                return
            }
            
            imageView.loadImage(urlString: url)
            titleLabel.text = offer?.foodName
            
            guard let price = offer?.foodPrice else {return}
            priceLabel.text = "\(price)Tk"
            discountTitle.text = offer?.discount
        }
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView ()
        iv.image = #imageLiteral(resourceName: "menu-1")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let offerView: UIImageView = {
        let iv = UIImageView ()
        iv.image = #imageLiteral(resourceName: "discount")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let discountTitle: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tv.font = UIFont(name: "Helvetica", size: 20)
        tv.numberOfLines = 0
        tv.textAlignment = .center
        return tv
    }()
    
    let titleLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Mexican Hot pizza"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tv.font = UIFont(name: "Helvetica", size: 20)
        
        return tv
    }()
    
    let categoryLabel: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 0.7215129733, green: 0.7217592597, blue: 0.7133134007, alpha: 1)
        tv.font = UIFont(name: "Helvetica", size: 16)
        return tv
    }()
    
    let priceLabel: UILabel = {
        let tv = UILabel()
        tv.text = "600Tk"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 0.406298697, green: 0.7874150872, blue: 0.1792633235, alpha: 1)
        tv.font = UIFont(name: "Helvetica", size: 18)
        return tv
    }()
    
    let contentBackground: UIView = {
        let cb = UIView()
        cb.backgroundColor = .white
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    func setUpViews(){
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        imageView.addSubview(contentBackground)
        contentBackground.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 70)
        
        imageView.addSubview(offerView)
        offerView.anchor(top: imageView.topAnchor, left: nil, bottom: nil, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: 60, height: 80)
        
        offerView.addSubview(discountTitle)
        discountTitle.anchor(top: offerView.topAnchor, left: offerView.leftAnchor, bottom: offerView.bottomAnchor, right: offerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        
        contentBackground.addSubview(titleLabel)
        contentBackground.addSubview(categoryLabel)
        contentBackground.addSubview(priceLabel)
        
        titleLabel.anchor(top: contentBackground.topAnchor, left: contentBackground.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 0, height: 30)
        
        
        categoryLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: contentBackground.bottomAnchor, right: contentBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 10, width: 0, height: 20)
        
        
        priceLabel.anchor(top: titleLabel.topAnchor, left: titleLabel.rightAnchor, bottom: titleLabel.bottomAnchor, right: contentBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 5, paddingBottom: 0, width: 60, height: 0)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
