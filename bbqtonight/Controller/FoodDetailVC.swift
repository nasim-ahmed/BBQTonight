//
//  FoodDetailVC.swift
//  Lamisa
//
//  Created by Nasim on 4/5/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

class FoodDetailVC: UIViewController {
    
    var foodItem: Post?
    
    let foodImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "meal")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let bottomView: UIView = {
        let tv = UIView()
        tv.backgroundColor = .black
        tv.alpha = 0.3
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let topView: UIView = {
        let tv = UIView()
        tv.backgroundColor = .black
        tv.alpha = 0.3
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    

    
    let titleLabel: UILabel = {
        let tv = UILabel()
        tv.text = "This is a dummy text"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.font = UIFont(name: "Helvetica-Bold", size: 20)
        tv.numberOfLines = 0
        //        tv.backgroundColor = .blue
        return tv
    }()
    

    let priceLabel: UILabel = {
        let tv = UILabel()
        tv.text = "100Tk"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tv.font = UIFont(name: "Cochin", size: 18)
        //        tv.backgroundColor = .red
        return tv
    }()
    
    let backButton: UIButton = {
        let button  = UIButton()
        button.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let orderButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Order", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleOrder), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let imageUrl = foodItem?.imageUrl else {return}
        
        self.foodImageView.loadImage(urlString: imageUrl)
        self.titleLabel.text = foodItem?.foodName
        
        guard let price = foodItem?.foodPrice  else {return}
        self.priceLabel.text = "\(price)Tk"
    }
    
    @objc func handleDismiss(){
       dismiss(animated: true, completion: nil)
    }
    
    @objc func handleOrder(){
        
        let orderVC = OrderVC()
        orderVC.selectedFood = foodItem
        self.present(orderVC, animated: true, completion: nil)
        
    }
    
    func setUpViews(){
        
        view.addSubview(foodImageView)
        view.addSubview(topView)
        view.addSubview(backButton)
        view.addSubview(orderButton)
        view.addSubview(bottomView)
        
        
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
    
        
        
        foodImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        topView.anchor(top:view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 120)

        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 60, height: 50)
        
        orderButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingRight: 10, paddingBottom: 0, width: 60, height: 50)
        
        bottomView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 130)
        
        
        priceLabel.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 30, paddingRight: 0, paddingBottom: 30, width: 100, height: 20)
        
        titleLabel.anchor(top: nil, left: priceLabel.leftAnchor, bottom: priceLabel.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 30, paddingBottom: 10, width: 0, height: 40)
    
        
    }
}
