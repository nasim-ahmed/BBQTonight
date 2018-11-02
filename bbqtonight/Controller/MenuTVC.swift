//
//  MenuTVC.swift
//  Lamisa
//
//  Created by Nasim on 4/4/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

protocol MenuTVCDelegate {
    func passSelectedCategory(id: String)
}


class MenuTVC: UITableViewController {
    var delegate: MenuTVCDelegate?
    
    
    private let cellId = "cellId"
    private let headerCellId = "headerCell"

    
    var fetchedCategories = [Category]()
    
    var refCategories: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupProducts()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = fetchedCategories[indexPath.row].categoryName
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.backgroundColor = .clear
        
        cell.alpha = 0.5
        
        return cell
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
            self.tableView.reloadData()
        }
    }
    
    var postsArray = [Post]()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fetchedCategories[indexPath.row]

        let catId = item.catId


        delegate?.passSelectedCategory(id: catId)
        
        
    }
}
