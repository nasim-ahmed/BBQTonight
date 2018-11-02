//
//  Order+CoreDataProperties.swift
//  bbqtonight
//
//  Created by Nasim on 4/12/18.
//  Copyright © 2018 Nasim. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var quantity: Int64

}
