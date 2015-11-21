//
//  WLProductsCarouselViewController.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/21/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit
import MBProgressHUD

class WLProductsCarouselViewController: UIViewController
{
    @IBOutlet weak var productsCarousel : iCarousel!
    var productsArray: Array<WLProduct> = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.productsCarousel.type = .CoverFlow2
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
                self.productsCarousel.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }else
            {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        }
    }

    //MARK:- iCarousel Delegate and Datasource methods
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return self.productsArray.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var productName: UILabel
        var productDescription: UILabel
        var productImageView: UIImageView
        let productObj : WLProduct = productsArray[index]
        
        if (view == nil)
        {
            productImageView = UIImageView(frame:CGRect(x:0, y:0, width:250, height:250))
            productImageView.image = UIImage(named: "page.png")
            productImageView.contentMode = .ScaleAspectFit
            
            productName = UILabel(frame:CGRect(x:15, y:-10, width:220, height:70))
            productName.backgroundColor = UIColor.clearColor()
            productName.textColor = UIColor.blackColor()
            productName.numberOfLines = 2
            productName.textAlignment = .Center
            productName.font = UIFont.boldSystemFontOfSize(15)
            productName.tag = 1
            productImageView.addSubview(productName)
            
            productDescription = UILabel(frame:CGRect(x:0, y:200, width:220, height:30))
            productDescription.backgroundColor = UIColor.clearColor()
            productDescription.numberOfLines = 1
            productDescription.textColor = UIColor(red: 0, green: 98/255.0, blue: 1, alpha: 1)
            productDescription.textAlignment = .Center
            productDescription.font = UIFont.boldSystemFontOfSize(13)
            productDescription.tag = 2
            productImageView.addSubview(productDescription)
        }
        else
        {
            productImageView = view as! UIImageView;
            productName = productImageView.viewWithTag(1) as! UILabel!
            productDescription = productImageView.viewWithTag(2) as! UILabel!
        }
        
        productImageView.sd_setImageWithURL(NSURL(string: (productObj.productImage)!), placeholderImage: UIImage(named: "product_icon"))
        productName.text = productObj.productName
        productDescription.text = "Price: " + productObj.price!
        
        return productImageView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }
    
    func carouselDidScroll(carousel : iCarousel)
    {
        if Int(carousel.scrollOffset) == (productsArray.count - 5)
        {
            self.loadProducts()
        }
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int)
    {
        let containerViewController : WLContainerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WLContainerViewController") as! WLContainerViewController
        containerViewController.productsArray = self.productsArray
        containerViewController.defaultPageIndex = index
        self.navigationController?.pushViewController(containerViewController, animated: true)
    }
}
