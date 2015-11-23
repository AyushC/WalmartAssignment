//
//  WLProduct.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/19/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import Foundation

class WLProduct: NSObject, NSCoding
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
    
    //MARK:- NSCoding
    required init(coder decoder: NSCoder)
    {
        self.productId = decoder.decodeObjectForKey("productId") as? String
        self.productName = decoder.decodeObjectForKey("productName") as? String
        self.shortDescription = decoder.decodeObjectForKey("shortDescription") as? String
        self.longDescription = decoder.decodeObjectForKey("longDescription") as? String
        self.price = decoder.decodeObjectForKey("price") as? String
        self.productImage = decoder.decodeObjectForKey("productImage") as? String
        self.reviewRating = decoder.decodeFloatForKey("reviewRating")
        self.reviewCount = decoder.decodeIntegerForKey("reviewCount")
        self.inStock = decoder.decodeBoolForKey("inStock")
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.productId, forKey: "productId")
        coder.encodeObject(self.productName, forKey: "productName")
        coder.encodeObject(self.shortDescription, forKey: "shortDescription")
        coder.encodeObject(self.longDescription, forKey: "longDescription")
        coder.encodeObject(self.price, forKey: "price")
        coder.encodeObject(self.productImage, forKey: "productImage")
        coder.encodeFloat(self.reviewRating!, forKey: "reviewRating")
        coder.encodeInteger(self.reviewCount!, forKey: "reviewCount")
        coder.encodeBool(self.inStock!, forKey: "inStock")
    }
    
}