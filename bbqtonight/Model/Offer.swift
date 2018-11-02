//
//  Offer.swift
//  bbqtonight
//
//  Created by Nasim on 4/17/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import Foundation

struct Offer{
    let offerId: String
    
    let foodName: String
    let foodPrice: Int
    let imageUrl: String
    let discount: String
    
    init(offerId: String, dictionary: [String: Any]) {
        self.offerId = offerId
        self.foodName = dictionary["name"] as? String ?? ""
        self.foodPrice = dictionary["price"] as? Int ?? 0
        self.imageUrl = dictionary["url"] as? String ?? ""
        self.discount = dictionary["discount"] as? String ?? ""
    }
}
