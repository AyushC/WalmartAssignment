//
//  WLProductDetailViewController.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/19/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit

class WLProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productDetailTableView: UITableView!
    @IBOutlet weak var productHeaderView: WLProductHeaderView!
    
    var productObj: WLProduct?
    var pageIndex: Int!

    private var productDetailArray: Array<Dictionary<String, String>> = []
    private let WL_PRODUCT_DETAIL_CELL_PADDING : CGFloat = 40.0
    private let WL_PRODUCT_DETAIL_CELL_DEFAULT_HEIGHT : CGFloat = 25.0


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.productHeaderView.setUpProductHeaderView(productObj!)
        self.productDetailTableView.tableFooterView = UIView()
        
        productDetailArray.append(["Price" : (productObj?.price)!])
        productDetailArray.append(["Rating" : String((productObj?.reviewRating)!)])
        productDetailArray.append(["Reviews" : String((productObj?.reviewCount)!)])
        
        if let description = productObj?.longDescription
        {
            productDetailArray.append(["Description" : description])
        }
        
        self.productDetailTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UITableView Delegate and Datasource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productDetailArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("WLProductDetailCell", forIndexPath: indexPath) as! WLProductDetailCell
        cell.setUpProductDetailCell(productDetailArray[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let productDict = productDetailArray[indexPath.row]
        let strDetail : String = productDict[Array(productDict.keys).first!]!

        return strDetail.heightWithConstrainedWidth(tableView.bounds.size.width - WL_PRODUCT_DETAIL_CELL_PADDING, font: UIFont.systemFontOfSize(15)) + WL_PRODUCT_DETAIL_CELL_DEFAULT_HEIGHT
    }
}