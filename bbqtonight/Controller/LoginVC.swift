//
//  LoginVC.swift
//  Lamisa
//
//  Created by Nasim on 4/4/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

class LoginVC: UIViewController {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "background")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Lamisa"
        label.font = UIFont(name: "MarkerFelt-Thin", size: 40)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    let loginButton: UIButton = {
        let lb = UIButton()
        lb.setTitle("Login with Facebook", for: .normal)
        lb.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        lb.layer.cornerRadius = 20
        lb.layer.masksToBounds = true
        lb.backgroundColor = #colorLiteral(red: 0.3054451644, green: 0.4800293446, blue: 0.7622482777, alpha: 1)
        lb.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return lb
    }()
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    var loginSuccess = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if FBSDKAccessToken.current() != nil {
            
            FbLoginManager.getFbUserData {
                self.loginButton.setTitle("CONTINUE WITH \(User.current.name!)", for: .normal)
            }
        }else {
            loginButton.setTitle("CONTINUE WITH FACEBOOK", for: .normal)
        }
    }
    
    @objc func handleLogin(){
        if FBSDKAccessToken.current() != nil{
            loginSuccess = true
            self.showRestaurants()
        }else{
            FbLoginManager.shared.logIn(withReadPermissions: ["public_profile","email"], from: self, handler: { (result, error) in
                if error  == nil {
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    //login user to firebase
                    
                    Auth.auth().signIn(with: credential, completion: { (user, error) in
                        if let error = error {
                            print("Error firebase error:" , error.localizedDescription)
                            return
                        }
                        
                        FbLoginManager.getFbUserData {
                            self.loginSuccess = true
                            self.showRestaurants()
                        }
                        
                    })
                    
                } else {
                    print("Error facebook login :" , error!.localizedDescription)
                }
                
            })
        }
    }
    
    func showRestaurants(){
        if FBSDKAccessToken.current() != nil && loginSuccess {
            let restaurantVC = UINavigationController(rootViewController: FoodCategoryVC())
            self.present(restaurantVC, animated: true, completion: nil)
        }
    }
    
    func setUpView(){
        view.addSubview(imageView)
        view.addSubview(logoLabel)
        view.addSubview(loginButton)
        
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        logoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 40)
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 20, width: 0, height: 40)
        
    }
}
