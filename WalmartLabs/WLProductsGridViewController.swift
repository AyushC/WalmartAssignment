//
//  WLProductsGridViewController.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/21/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit
import MBProgressHUD

class WLProductsGridViewController: UIViewController
{
    @IBOutlet weak var productCollectionView: UICollectionView!
    var productsArray: Array<WLProduct> = []
    let threshold = 100.0
    var isLoadingMore = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Products"
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.loadProducts()
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
                self.productCollectionView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.isLoadingMore = false
            }else
            {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        }
    }
    
    //MARK:- UICollectionView Delegate and Datasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.productsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WLProductCollectionCell", forIndexPath: indexPath) as! WLProductCollectionCell
        cell.setUpProductCollectionCellForProduct(self.productsArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
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
