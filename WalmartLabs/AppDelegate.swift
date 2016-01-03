//
//  AppDelegate.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/19/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import UIKit
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        BITHockeyManager.sharedHockeyManager().configureWithIdentifier("561866ec949c4081929bbe6c5cd56ddd");
        BITHockeyManager.sharedHockeyManager().startManager();
        BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation(); // This line is obsolete in the crash only build
        //self.retrieveLoadedProducts()

        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
        //self.saveLoadedProducts()
    }

    func applicationWillEnterForeground(application: UIApplication)
    {
        //self.retrieveLoadedProducts()
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func saveLoadedProducts()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(WLBackendUtility.WL_PRODUCTS_COUNT, forKey: "ProductsCount")
        defaults.setInteger(WLBackendUtility.WL_TOTAL_PRODUCTS_COUNT, forKey: "TotalProducts")
        defaults.setInteger(WLBackendUtility.WL_PAGE_NUMBER, forKey: "PageNumber")
        let productsData = NSKeyedArchiver.archivedDataWithRootObject(WLProductsDataManager.sharedInstance.productsArray)
        defaults.setObject(productsData, forKey: "ProductsArray")
        defaults.synchronize()
    }
    
    func retrieveLoadedProducts()
    {
        let defaults = NSUserDefaults.standardUserDefaults()

        if let productsData = defaults.objectForKey("ProductsArray") as? NSData
        {
            WLProductsDataManager.sharedInstance.productsArray =  (NSKeyedUnarchiver.unarchiveObjectWithData(productsData) as? [WLProduct])!
            WLBackendUtility.WL_PRODUCTS_COUNT = defaults.integerForKey("ProductsCount")
            WLBackendUtility.WL_TOTAL_PRODUCTS_COUNT = defaults.integerForKey("TotalProducts")
            WLBackendUtility.WL_PAGE_NUMBER = defaults.integerForKey("PageNumber")
        }
    }
}

