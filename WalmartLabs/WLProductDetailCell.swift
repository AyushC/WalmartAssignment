//
//  WLProductDetailCellTableViewCell.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/20/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit

class WLProductDetailCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel?
    
    func setUpProductDetailCell(productDict : Dictionary<String, String>)
    {
        self.title?.text = Array(productDict.keys).first
        self.subtitle?.text = productDict[(self.title?.text)!]
    }
}
