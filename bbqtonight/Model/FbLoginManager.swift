//
//  FbLoginManager.swift
//  Lamisa
//
//  Created by Nasim on 4/4/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON
import Firebase


class FbLoginManager {
    
    
    static let shared = FBSDKLoginManager()
    
    public class func getFbUserData(completion : @escaping () -> Void)
    {
        
        if FBSDKAccessToken.current() != nil {
            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "name , email , picture.type(normal)"])!
            
            request.start(completionHandler: { (connection, result, error) in
                if error == nil {
                    let json = JSON(result!)
                    //we have the user infornation : name , email , id
                    
                    
                    User.current.setUser(json: json)
                    completion()
                }
                
            })
        }
    }
}

