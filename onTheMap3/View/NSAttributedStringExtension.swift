//
//  NSAttributedStringExtension.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 19/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation

extension NSAttributedString {
    static func makeHyperLink(for path:String, in String:String , as substring:String )-> NSAttributedString{
        let nsString = NSString(string: String)
        let subStringRange = nsString.range(of:substring)
        let attributedString = NSMutableAttributedString(string: String)
        attributedString.addAttribute(.link, value: path, range: subStringRange)
          
        return attributedString
    }
    
    
}
