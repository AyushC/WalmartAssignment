//
//  String+HtmlTextProcessor.swift
//  WalmartLabs
//
//  Created by Ayush Chamoli on 11/20/15.
//  Copyright © 2015 Ayush Chamoli. All rights reserved.
//

import Foundation

extension String {
    
    func processHtmlString() ->String?
    {
        do
        {
            let regex = try NSRegularExpression(pattern: "<.*?>", options: NSRegularExpressionOptions.CaseInsensitive)
            let range = NSMakeRange(0, self.characters.count)
            var readibleString :String = regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range:range , withTemplate: "")
            
            readibleString = readibleString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            readibleString = readibleString.stringByReplacingOccurrencesOfString("&nbsp;", withString:"")
            readibleString = readibleString.stringByReplacingOccurrencesOfString("\t", withString:"")
            
            return readibleString
            
        } catch
        {
            print(error)
        }
        
        return nil
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}