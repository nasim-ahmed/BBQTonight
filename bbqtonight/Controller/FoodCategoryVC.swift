//
//  RestaurantVC.swift
//  Lamisa
//
//  Created by Nasim on 4/4/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

class FoodCategoryVC: UITableViewController, CDRTranslucentSideBarDelegate, MenuControllerDelegate{
    
    var categoryId: String?
    
    
    
    func passSelectedCategory(id: String) {
//        leftSideBar?.dismiss(animated: true)
//        categoryId = id
        
//        fetchPosts(catId: id)
    }
    
    
    var leftSideBar: CDRTranslucentSideBar?
    let tableCelId = "tableCellId"
    
    var foodsArray = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        setUpFoods()

        view.backgroundColor = .white
        
//      setUpNavigationButton()
//      setupLeftSideBar()
        
        tableView.register(FoodCell.self, forCellReuseIdentifier: tableCelId)
        
        navigationItem.title = "Appetizers/salads"
     
        self.navigationController!.navigationBar.isTranslucent = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let id = categoryId{
            fetchPosts(catId: id)
        }
    }
    
    
    func fetchPosts(catId: String){
        let postsRef = Database.database().reference().child("Posts").child(catId)
        
        postsRef.observe(.value, with: { (snapshot) in
            self.foodsArray.removeAll()
            
            let array = snapshot.children.allObjects as! [DataSnapshot]
            
            array.forEach({ (snap) in
                let postId = snap.key
                guard let dictionary = snap.value as? [String: Any] else {return}
                let post = Post(postId: postId, dictionary: dictionary)
                self.foodsArray.append(post)
            })
            
            self.tableView.reloadData()
            
            //   print(self.postsArray)
            
        }) { (error) in
            print("Failed to fetch posts:", error)
        }
    }
    
    func setUpFoods(){
        let ref = Database.database().reference().child("Posts")
        
        ref.observe(.value) { (snapshot) in
            self.foodsArray.removeAll()
            
            let postArray = snapshot.children.allObjects as! [DataSnapshot]
            postArray.forEach({ (snap) in
                let catArray = snap.children.allObjects as! [DataSnapshot]
                catArray.forEach({ (child) in
                    let postId = child.key
                    guard let dictionary = child.value as? [String: Any] else {return}
                    let post = Post(postId: postId, dictionary: dictionary)
                    self.foodsArray.append(post)
                })
            })
            
           self.tableView.reloadData()

        }
    }
    
    
//    func setUpNavigationButton(){
//        let menu = #imageLiteral(resourceName: "menu")
//
//        let leftBarBut = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: self, action: #selector(showLeftBar))
//        leftBarBut.image = menu
//        leftBarBut.tintColor = .white
//        self.navigationItem.leftBarButtonItem = leftBarBut
//    }
//
//    func setupLeftSideBar() {
//        leftSideBar = CDRTranslucentSideBar()
//        leftSideBar?.delegate = self
//        leftSideBar?.tag = 0
//        leftSideBar?.sideBarWidth = view.frame.width * 0.6
//        leftSideBar?.translucentAlpha = 0.75
//        leftSideBar?.animationDuration = 0.5
//        leftSideBar?.translucentTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//
////        let menuTVC = MenuTVC()
////        menuTVC.delegate = self
////        self.addChildViewController(menuTVC)
////        menuTVC.view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
////        leftSideBar?.setContentViewIn(menuTVC.view)
////        menuTVC.didMove(toParentViewController: self)
//
//        let sidebar = SidebarMenu()
//
//        self.addChildViewController(sidebar)
//        sidebar.view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
//        leftSideBar?.setContentViewIn(sidebar.view)
//        sidebar.didMove(toParentViewController: self)
//
//
//    }
    
    
    @objc func showLeftBar() {
        leftSideBar?.show()
        
    }
    
   
    
    
}

extension FoodCategoryVC{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCelId, for: indexPath) as! FoodCell
        let item = foodsArray[indexPath.row]
        
        cell.food = item
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 30, 0)
        cell.layer.transform = transform

        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       let itemSelected = foodsArray[indexPath.row]
       
       let foodDetailVC = FoodDetailVC()
       foodDetailVC.foodItem = itemSelected
       self.present(foodDetailVC, animated: true, completion: nil)
    }
    
   
}
