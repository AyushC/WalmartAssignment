//
//  WLBackendUtility.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/19/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import Foundation

class WLBackendUtility: NSObject
{
    typealias CompletionBlock =  (productsArray : Array<Dictionary<String,AnyObject>>) -> Void
    
    private static let WL_PRODUCTS_API_KEY        = "6336b3b1-ccb6-426e-b3aa-3696416aa299"
    
    private static var WL_PAGE_NUMBER             = 1
    private static let WL_PAGE_SIZE               = 20
    private static var WL_TOTAL_PRODUCTS_COUNT    = 0
    private static var WL_PRODUCTS_COUNT          = 0
    
    private static let SESSION_TIME_OUT_PERIOD      = 30.0
    
    // MARK : - Root URL
    private static let WL_ROOT_URL               = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1"
    
    // MARK: - EndPoint URLs
    internal enum EndPointURL: String
    {
        case GetProductsList                     = "/walmartproducts/"
    }
    
    class func requestProductsDataWithCompletionBlock(compBlock: CompletionBlock) -> Bool
    {
        // Check if request is possible
        if WL_TOTAL_PRODUCTS_COUNT > WL_PRODUCTS_COUNT || WL_TOTAL_PRODUCTS_COUNT == 0
        {
            requestWithURL(WL_ROOT_URL, endPointURL: EndPointURL.GetProductsList.rawValue, andCompletionBlock: compBlock)
        } else
        {
            print("All Products loaded Successfully.")
            return false
        }
        
        return true
    }
    
    internal class func requestWithURL(rootURL:String, endPointURL: String?, andCompletionBlock compBlock: CompletionBlock)
    {
        
        var urlString = rootURL
        if endPointURL != nil
        {
            urlString = urlString + endPointURL!
            urlString = urlString + WL_PRODUCTS_API_KEY + "/" + String(WL_PAGE_NUMBER) + "/" + String(WL_PAGE_SIZE)
        }
        
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        
        print("=============================CALLING API=============================")
        print(urlString)
        
        session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse
            {
                if httpResponse.statusCode == 200
                {
                    if let receivedData = data
                    {
                        do
                        {
                            let jsonDict = try NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments) as? [String : AnyObject]
                            
                            let resultCode = jsonDict!["status"] as? Int
                            
                            if resultCode == 200
                            {
                                WL_PAGE_NUMBER = (jsonDict!["pageNumber"] as? Int)! + 1
                                WL_TOTAL_PRODUCTS_COUNT = (jsonDict!["totalProducts"] as? Int)!
                                WL_PRODUCTS_COUNT = WL_PRODUCTS_COUNT + (jsonDict!["pageSize"] as? Int)!
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    compBlock(productsArray: (jsonDict!["products"] as? Array<Dictionary<String,AnyObject>>)!)
                                })
                            }
                            
                        } catch let error as NSError
                        {
                            print("json error: \(error.localizedDescription)")
                        }
                    }
                    
                }
            }else
            {
                print("Error description: \(error!.localizedDescription)")
                dispatch_async(dispatch_get_main_queue(),
                    {
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        let errorAlert: UIAlertController = UIAlertController(title: String(error!.code), message: error!.localizedDescription, preferredStyle: .Alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        appDelegate.window?.rootViewController!.presentViewController(errorAlert, animated: true, completion: nil)
                        compBlock(productsArray: [])
                })
            }
            
            }.resume()
        
    }
    
}
