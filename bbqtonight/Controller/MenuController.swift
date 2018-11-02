//
//  MenuController.swift
//  bbqtonight
//
//  Created by Nasim on 4/8/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

private let cellID = "cellID"
private let cellId = "cellId"
private let tableViewCelId = "tableCellId"

protocol MenuControllerDelegate {
    func passSelectedCategory(id: String)
}

class MenuController: UICollectionViewController,UICollectionViewDelegateFlowLayout, CDRTranslucentSideBarDelegate{
    
    var delegate: MenuControllerDelegate?

    var leftSideBar: CDRTranslucentSideBar?
    var refCategories: DatabaseReference!
    
    var fetchedCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        navigationItem.title = "Menu"

        setupProducts()
        
        setUpNavigationButton()
        
        setupLeftSideBar()
  
    }
    

    func setUpNavigationButton(){
        let menu = #imageLiteral(resourceName: "menu")
        
        let leftBarBut = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: self, action: #selector(showLeftBar))
        leftBarBut.image = menu
        leftBarBut.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftBarBut
    }
    
    
    func setupLeftSideBar() {
        leftSideBar = CDRTranslucentSideBar()
        leftSideBar?.delegate = self
        leftSideBar?.tag = 0
        leftSideBar?.sideBarWidth = view.frame.width * 0.6
        leftSideBar?.translucentAlpha = 0.75
        leftSideBar?.animationDuration = 0.5
        leftSideBar?.translucentTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let sidebar = SidebarMenu()
        
        self.addChildViewController(sidebar)
        sidebar.view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
        leftSideBar?.setContentViewIn(sidebar.view)
        sidebar.didMove(toParentViewController: self)
        
    }
    
    @objc func showLeftBar() {
        leftSideBar?.show()
        
    }
    

    func setupA() {
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func setupB(){
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            setupA()
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeCell
            return cellA
        } else {
            setupB()
            
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
            
            let item = fetchedCategories[indexPath.item - 1]
            cellB.product = item
            
            return cellB
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedCategories.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 300)
        } else {
            return CGSize(width: view.frame.width, height: 200)
        }
    }
    
    func setupProducts() {
        refCategories = Database.database().reference().child("Categories")
        
        refCategories.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            
            dictionaries.forEach({ (key, value) in
                
                guard let categoryDictionary = value as? [String: Any] else {return}
                
                let category = Category(catId: key, dictionary: categoryDictionary)
                self.fetchedCategories.append(category)
            })
            
            self.collectionView?.reloadData()
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = fetchedCategories[indexPath.item - 1]

        let catId = item.catId
    
        let categoryVC = FoodCategoryVC()
        categoryVC.categoryId = catId
        

//       delegate?.passSelectedCategory(id: catId)
        
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    

}
