//
//  WLProductCollectionCellCollectionViewCell.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/21/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit

class WLProductCollectionCell: UICollectionViewCell
{
    @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productShortDescription: UILabel?
    
    func setUpProductCollectionCellForProduct(productObj : WLProduct)
    {
        self.productName.text = productObj.productName
        self.productShortDescription?.text = "Price: " + productObj.price!
        self.productImageview?.sd_setImageWithURL(NSURL(string: (productObj.productImage)!), placeholderImage: UIImage(named: "product_icon"))
    }
}
