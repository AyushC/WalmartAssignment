//
//  WLProductHeaderView.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/20/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit

class WLProductHeaderView: UIView
{
    @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    func setUpProductHeaderView(productObj : WLProduct)
    {
        self.productName.text = productObj.productName
        self.productImageview?.sd_setImageWithURL(NSURL(string: (productObj.productImage)!), placeholderImage: UIImage(named: "product_icon"))
    }
}
