//
//  OrderVC.swift
//  bbqtonight
//
//  Created by Nasim on 4/7/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import CoreData

class OrderVC: UIViewController {
    var selectedFood: Post?
    
    
    let foodImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "meal")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let backButton: UIButton = {
        let button  = UIButton()
        button.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let tv = UILabel()
        tv.text = "This is a dummy text"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tv.font = UIFont(name: "Helvetica-Bold", size: 18)
        tv.numberOfLines = 0
        tv.textAlignment = .center
        //        tv.backgroundColor = .blue
        return tv
    }()
    
    
    let priceLabel: UILabel = {
        let tv = UILabel()
        tv.text = "50 Tk"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        tv.font = UIFont(name: "Avenir Next Regular", size: 17)
        return tv
    }()


    
    let underlineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let addToCart: UIButton = {
        let button  = UIButton()
        button.setTitle("Add to cart", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
        return button
    }()
    
    let plusButton: UIButton = {
        let button  = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleIncrement), for: .touchUpInside)
        return button
    }()
    
    
    let minusButton: UIButton = {
        let button  = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDecrement), for: .touchUpInside)
        return button
    }()
    
    
    let containerView: UIView = {
        let cv = UIView()
//        cv.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black
        cv.alpha = 0.6
        return cv
    }()
    
    
    let countLabel: UILabel = {
        let tv = UILabel()
        tv.text = "15"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tv.text = "1"
        tv.textAlignment = .center
        return tv
    }()
    
    
    let detailLabel: UILabel = {
        let tv = UILabel()
        tv.text = "A really long recipe goes here to show the customer how tasty te thing is"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tv.font = UIFont(name: "Avenir Next Regular", size: 17)
        tv.numberOfLines = 0
        tv.textAlignment = .center
        return tv
    }()
    
    let backViewSv: UIView = {
        let bv = UIView()
        bv.layer.cornerRadius = 16
        bv.layer.borderWidth = 2
        bv.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        bv.layer.masksToBounds = true
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
 
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpViews()
        
        guard let url = selectedFood?.imageUrl else {return}
        
        foodImageView.loadImage(urlString: url)
        titleLabel.text = selectedFood?.foodName
        
        guard let price = selectedFood?.foodPrice else {return}
        priceLabel.text = "\(price)Tk"
       
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setUpViews(){
        view.addSubview(foodImageView)
        foodImageView.addSubview(containerView)
        foodImageView.addSubview(titleLabel)
        foodImageView.addSubview(priceLabel)
        
        containerView.anchor(top: nil, left: foodImageView.leftAnchor, bottom: foodImageView.bottomAnchor, right: foodImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        view.addSubview(backButton)
    
        view.addSubview(detailLabel)
        
        view.addSubview(backViewSv)
        
        let sv = UIStackView(arrangedSubviews: [minusButton, countLabel, plusButton])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.layer.cornerRadius = 10
        sv.layer.masksToBounds = true
        sv.layer.borderWidth = 2.0
        
        view.addSubview(sv)
        
      
        
        view.addSubview(addToCart)
        

        
        foodImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: view.frame.width, height: view.frame.width)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 60, height: 50)
        
        titleLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor , bottom: containerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor , multiplier: 0.7).isActive = true
        
    
        
        priceLabel.anchor(top: containerView.topAnchor, left: titleLabel.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        priceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
       
        
        detailLabel.anchor(top:foodImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10, paddingBottom: 5, width: 0, height: 0)
        
        backViewSv.anchor(top: sv.topAnchor, left: sv.leftAnchor, bottom: sv.bottomAnchor, right: sv.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        
        sv.anchor(top: detailLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 10, width: 132, height: 0)
        sv.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        addToCart.anchor(top: sv.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 50)
    }
    
    var orderAmount = 1
    
    @objc func handleAddToCart(){   
        if let food = selectedFood{
            
//            self.clearData()
            self.saveInCoreDataWith(selectedFood: food)
            DispatchQueue.main.async {
                let savedLabel = UILabel()
                savedLabel.text = "Added to cart"
                savedLabel.textColor = .white
                savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
                savedLabel.numberOfLines = 0
                savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.7)
                savedLabel.textAlignment = .center
                savedLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 120)
                savedLabel.center = self.view.center
                
                self.view.addSubview(savedLabel)
                
                
                
                savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        savedLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                    }, completion: { (_) in
                        savedLabel.removeFromSuperview()
                        savedLabel.alpha = 0
                    })
                    
                })
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    func saveInCoreDataWith(selectedFood: Post){
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let orderEntity = NSEntityDescription.insertNewObject(forEntityName: "Order", into: context) as? Order{
            orderEntity.id = selectedFood.postId
            orderEntity.name = selectedFood.foodName
            guard let totalPrice = calculatedFoodPrice else {return}
            orderEntity.price = Int64(totalPrice)
            orderEntity.image = selectedFood.imageUrl
            orderEntity.quantity = Int64(orderAmount)
        }
        
        do{
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        }catch let error{
            print(error)
        }
  
    }
    
    
    @objc func handleDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    var calculatedFoodPrice: Int?
        
    @objc func handleIncrement(){
        
        orderAmount = orderAmount + 1
        guard let price = selectedFood?.foodPrice else {return}
        calculatedFoodPrice = price * orderAmount
        guard let unwrappedPrice = calculatedFoodPrice else {return}
        
        self.countLabel.text = String(describing: orderAmount)
        self.priceLabel.text = "  \(unwrappedPrice)Tk"
    }
    
    @objc func handleDecrement(){
        if orderAmount > 0{
            
          orderAmount = orderAmount - 1
          
          guard let actualPrice = selectedFood?.foodPrice, let currentPrice = calculatedFoodPrice else {return}
         
            
          calculatedFoodPrice = currentPrice - actualPrice
            
           guard let unwrappedPrice = calculatedFoodPrice else {return}
            
        
          self.countLabel.text = String(describing: orderAmount)
          self.priceLabel.text = "\(unwrappedPrice)Tk"
          
            
        }else{
            //Do nothing
        }
    }
    
    func clearData(){
        
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Order.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
                print("Data cleared")
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    
}
