//
//  WLProduct.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/19/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import Foundation

class WLProduct: NSObject
{
    var productId: String?
    var productName: String?
    var shortDescription: String?
    var longDescription: String?
    var price: String?
    var productImage: String?
    var reviewRating: Float?
    var reviewCount: NSInteger?
    var inStock: Bool?

    
    init(_ productsDict: Dictionary<String, AnyObject>)
    {
        self.productId = productsDict["productId"] as? String
        self.productName = productsDict["productName"] as? String
        
        if let strShortDesc = productsDict["shortDescription"] as?  String
        {
            self.shortDescription = strShortDesc.processHtmlString()
        }
        
        if let strLongDesc = productsDict["longDescription"] as?  String
        {
            self.longDescription = strLongDesc.processHtmlString()
        }
        
        self.price = productsDict["price"] as? String
        self.productImage = productsDict["productImage"] as? String
        self.reviewRating = productsDict["reviewRating"] as? Float
        self.reviewCount = productsDict["reviewCount"] as? NSInteger
        self.inStock = productsDict["inStock"] as? Bool
    }
    
}