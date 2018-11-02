//
//  SidebarMenu.swift
//  bbqtonight
//
//  Created by Nasim on 4/8/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

class SidebarMenu: UITableViewController {
    
    private let cellId = "cellId"
    
    var menus = [Sidebar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenus()

        tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        
        tableView.register(SidebarCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SidebarCell
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.backgroundColor = .clear
        
        let menu = menus[indexPath.row]
        cell.menu = menu
        
        return cell
    }
    
    func setUpMenus(){
        
        let menu1 = Sidebar(name: "Menu", icon: #imageLiteral(resourceName: "restaurant").withRenderingMode(.alwaysOriginal))
        let menu2 = Sidebar(name: "Offers", icon: #imageLiteral(resourceName: "offers").withRenderingMode(.alwaysOriginal))
        let menu3 = Sidebar(name: "My Cart", icon: #imageLiteral(resourceName: "shopping-cart").withRenderingMode(.alwaysOriginal))
        let menu4 = Sidebar(name: "Favorites", icon: #imageLiteral(resourceName: "star").withRenderingMode(.alwaysOriginal))
        let menu5 = Sidebar(name: "Settings", icon: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal))
        let menu6 = Sidebar(name: "Support", icon: #imageLiteral(resourceName: "support").withRenderingMode(.alwaysOriginal))
        
        menus = [menu1, menu2, menu3, menu4, menu5, menu6]
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
//            let layout = UICollectionViewFlowLayout()
//            let menuController = MenuController(collectionViewLayout: layout)
//            navigationController?.pushViewController(menuController, animated: true)
        }else if indexPath.row == 1{
            let offerVC = OfferVC()
            self.navigationController?.pushViewController(offerVC, animated: true)
            
        }else if indexPath.row == 2{
            let cartVC = MyCartVC()
            self.navigationController?.pushViewController(cartVC, animated: true)
            
        }
    }
   
    
   

}
