//
//  SidebarCell.swift
//  bbqtonight
//
//  Created by Nasim on 4/8/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

class SidebarCell: UITableViewCell {
    
    var menu: Sidebar?{
        didSet{
            title.text = menu?.name
            menuImage.image = menu?.icon
        }
    }
    
    let menuImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "restaurant").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let title: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textColor = .white
        tl.font = UIFont(name: "DINAlternate-Bold ", size: 15)
        return tl
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        addSubview(menuImage)
        addSubview(title)
        
        menuImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 15, paddingRight: 0, paddingBottom: 10, width: 25, height: 25)
        
        
        title.anchor(top: topAnchor, left: menuImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: 15, paddingBottom: 0, width: 0, height: 0)
        
    }
    
    
    
}
