//
//  WLProductCell.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/19/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import Foundation
import UIKit

class WLProductCell : UITableViewCell
{
    @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productShortDescription: UILabel?
    
    func setUpProductCellForProduct(productObj : WLProduct)
    {
        self.productName.text = productObj.productName
        
        if productObj.shortDescription != nil
        {
            self.productShortDescription?.text = productObj.shortDescription
        }else
        {
            self.productShortDescription?.text = productObj.longDescription
        }
        
        self.productImageview?.sd_setImageWithURL(NSURL(string: (productObj.productImage)!), placeholderImage: UIImage(named: "product_icon"))
    }
    
}