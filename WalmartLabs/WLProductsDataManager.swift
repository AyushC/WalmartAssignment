//
//  WlProductsDataManager.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/21/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit

class WLProductsDataManager: NSObject {

    static let sharedInstance = WLProductsDataManager()
    
    var productsArray:[WLProduct]
    typealias CompletionBlock = Array<WLProduct>! -> Void
    
    private override init()
    {
        productsArray = []
    }
    
    func loadDataForProducts(completionBlock : CompletionBlock)
    {
        if (!WLBackendUtility.requestProductsDataWithCompletionBlock { (productsArray) -> Void in
            for productDict in productsArray
            {
                let productObj : WLProduct = WLProduct.init(productDict)
                self.productsArray.append(productObj)
            }
            
            completionBlock(self.productsArray)
            })
        {
            completionBlock(self.productsArray)
        }
    }

}
