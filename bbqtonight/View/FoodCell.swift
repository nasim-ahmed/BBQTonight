//
//  FoodCell.swift
//  Lamisa
//
//  Created by Nasim on 4/5/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    
    var foods = [Food]()
    
    var food: Post?{
        didSet{            
            guard let postImageUrl = food?.imageUrl else { return }
            
            foodImageView.loadImage(urlString: postImageUrl)
            
            self.titleLabel.text = food?.foodName
            
            guard let price = food?.foodPrice else {return}
            
            self.priceLabel.text = "\(price)Tk"
        }
    }

    let foodImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "meal")
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let topView: UIView = {
        let tv = UIView()
        tv.backgroundColor = .black
        tv.alpha = 0.5
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    let titleLabel: UILabel = {
        let tv = UILabel()
        tv.text = "This is a dummy text"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.font = UIFont(name: "Helvetica-Bold", size: 24)
        tv.numberOfLines = 0
//        tv.backgroundColor = .blue
        return tv
    }()
    
    let priceLabel: UILabel = {
        let tv = UILabel()
        tv.text = "$10"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.font = UIFont(name: "Cochin", size: 22)
//        tv.backgroundColor = .red
        return tv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        addSubview(foodImageView)
        foodImageView.addSubview(topView)

        foodImageView.addSubview(priceLabel)
        foodImageView.addSubview(titleLabel)
        
        foodImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        topView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)

        priceLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 0, paddingBottom: 10, width: 0, height: 20)

        titleLabel.anchor(top: nil, left: priceLabel.leftAnchor, bottom: priceLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 20, paddingBottom: 20, width: 0, height: 40)
    }
    
    
}
