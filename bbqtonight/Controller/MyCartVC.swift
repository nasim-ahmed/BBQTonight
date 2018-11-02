//
//  TestController.swift
//  bbqtonight
//
//  Created by Nasim on 4/10/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class MyCartVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var refOrders: DatabaseReference!
    
    var orders = [[String: Any]]()
    
    private let cellId = "cellId"
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Order.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let greenView: UIView = {
        let gv = UIView()
        gv.backgroundColor = #colorLiteral(red: 0.4, green: 0.7960784314, blue: 0.1647058824, alpha: 1)
        gv.translatesAutoresizingMaskIntoConstraints = false
        
        return gv
    }()
    
    let buyButton: UIButton = {
        let gv = UIButton()
        gv.setTitle("Buy", for: .normal)
        gv.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        gv.translatesAutoresizingMaskIntoConstraints = false
        gv.addTarget(self, action: #selector(handleBuyButton), for: .touchUpInside)
        return gv
    }()
    
    
    let totalPrice: UILabel = {
        let gv = UILabel()
        gv.translatesAutoresizingMaskIntoConstraints = false
        return gv
    }()
    
    @objc func handleBuyButton(){
        let key = self.refOrders.childByAutoId().key
        self.refOrders.child(key).setValue(orders)
        
        DispatchQueue.main.async {
            let savedLabel = UILabel()
            savedLabel.text = "Order Placed"
            savedLabel.textColor = .white
            savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
            savedLabel.numberOfLines = 0
            savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
            savedLabel.textAlignment = .center
            savedLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 120)
            savedLabel.center = self.tableView.center
            
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
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refOrders = Database.database().reference().child("Orders")
        

        // get the navigation bar from the current navigation controller if there is one
        let navBar = self.navigationController?.navigationBar
        
        // change the bar tint color to change what the color of the bar itself looks like
        navBar?.barTintColor = UIColor.black
        
        // tint color changes the color of the nav item colors eg. the back button
        navBar?.tintColor = UIColor.white
        
        // if you notice that your nav bar color is off by a bit, sometimes you will have to
        // change it to not translucent to get correct color
        navBar?.isTranslucent = false
        
        // the following attribute changes the title color
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationItem.title = "Cart"
        
        let rightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "clearcart").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleClearCart))
        
        navigationItem.rightBarButtonItem = rightBarItem
        

        tableView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9529411765, alpha: 1)
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        tableView.register(CartCell.self, forCellReuseIdentifier: cellId)
        
        view.backgroundColor = .red
    
        setUpViews()
        
        updateTableContent()
        
        
    }
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @objc func handleClearCart(){
           do {
                let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Order.self))
                do {
                    let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                    _ = objects.map{$0.map{context.delete($0)}}
                    CoreDataStack.sharedInstance.saveContext()
                    print("Data cleared")
                    self.tableView.reloadData()
                } catch let error {
                    print("ERROR DELETING : \(error)")
                }
            }
    }
    
    func updateTableContent() {
        
        do {
            try self.fetchedResultsController.performFetch()
            
        } catch let error  {
            print("Could not perform fetch", error)
        }
    }
    
    func setUpViews(){

        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        view.addSubview(greenView)
        greenView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 60)
        
        greenView.addSubview(buyButton)
        buyButton.anchor(top: greenView.topAnchor, left: greenView.leftAnchor, bottom: greenView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 50, height: 0)
        
        greenView.addSubview(totalPrice)
        totalPrice.anchor(top: greenView.topAnchor, left: nil, bottom: greenView.bottomAnchor, right: greenView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 10, paddingBottom: 0, width: 80, height: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultsController.sections?.first?.numberOfObjects{
            return count
        }
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CartCell
        
        cell.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9529411765, alpha: 1)
        
        if let order = fetchedResultsController.object(at: indexPath) as? Order{
            setDictionary(order: order)
            cell.setOrderCellWith(order: order)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func setDictionary(order: Order){
        let id = order.id
        let name = order.name
        let quantity = order.quantity
        let imageUrl = order.image
        
        
        let dictionary = ["id": id ?? "",
            "name": name ?? "",
            "quantity": quantity,
            "imageUrl": imageUrl] as [String : Any]
        orders.append(dictionary)
        
    }
}


extension MyCartVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
}
