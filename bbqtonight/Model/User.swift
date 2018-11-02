//
//  User.swift
//  Lamisa
//
//  Created by Nasim on 4/4/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var name: String?
    var email: String?
    var pictureURL:String?
    var id:String?
    static let current = User()
    
    func setUser(json: JSON){
        name = json["name"].string
        email = json["email"].string
        id = json["id"].string
        
        let imageDictionary = json["picture"].dictionary
        let dataDictionary = imageDictionary!["data"]?.dictionary
        pictureURL = dataDictionary!["URL"]?.string
    }
    
    func resetUser(){
        name = nil
        email = nil
        pictureURL = nil
        id = nil
    }
    
    
}
