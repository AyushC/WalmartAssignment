//
//  WLProductsListViewController.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/21/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit
import MBProgressHUD

class WLProductsListViewController: UIViewController
{
    @IBOutlet weak var productsTableView: UITableView!
    
    var productsArray: Array<WLProduct> = []
    let threshold = 100.0
    var isLoadingMore = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Products"
        self.productsTableView.tableFooterView = UIView()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if self.productsArray.count == 0
        {
            self.loadProducts()
        } else
        {
            self.productsArray.removeAll()
            self.productsArray = WLProductsDataManager.sharedInstance.productsArray
            self.productsTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func loadProducts()
    {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        WLProductsDataManager.sharedInstance.loadDataForProducts { (productsArray) -> Void in
            
            if productsArray != nil && productsArray.count > self.productsArray.count
            {
                self.productsArray.removeAll()
                self.productsArray = productsArray
                self.productsTableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.isLoadingMore = false
            }else
            {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        }
    }
    
    // MARK:- UITableView Delegate and Datasource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.productsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let productObj : WLProduct = productsArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("WLProductCell", forIndexPath: indexPath) as! WLProductCell
        cell.setUpProductCellForProduct(productObj)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let containerViewController : WLContainerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WLContainerViewController") as! WLContainerViewController
        containerViewController.productsArray = self.productsArray
        containerViewController.defaultPageIndex = indexPath.row
        self.navigationController?.pushViewController(containerViewController, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (Float(maximumOffset - contentOffset) <= Float(threshold))
        {
            self.isLoadingMore = true
            self.loadProducts()
        }
    }
}
