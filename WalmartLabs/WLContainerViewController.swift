//
//  WLContainerViewController.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/21/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit

class WLContainerViewController: UIViewController, UIPageViewControllerDataSource
{
    @IBOutlet weak var pageViewController: UIPageViewController!
    var productsArray: Array<WLProduct> = []
    var defaultPageIndex: Int!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Details"

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WLPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(self.defaultPageIndex) as WLProductDetailViewController
        let viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UIPageViewControllerDataSource methods
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        
    {
        let productDetailViewController = viewController as! WLProductDetailViewController
        var index = productDetailViewController.pageIndex as Int
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let vc = viewController as! WLProductDetailViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index++
        
        if (index == self.productsArray.count)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    // MARK: - Helper methods
    func viewControllerAtIndex(index: Int) -> WLProductDetailViewController
        
    {
        if ((self.productsArray.count == 0) || (index >= self.productsArray.count))
        {
            return WLProductDetailViewController()
        }
        
        let productDetailViewController: WLProductDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WLProductDetailViewController") as! WLProductDetailViewController
        productDetailViewController.productObj = productsArray[index]
        productDetailViewController.pageIndex = index
        
        return productDetailViewController
    }
}
