//
//  UIColor.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import SwiftHEXColors

extension UIColor {
    
    // MARK: - Background Color
    class func primary1() -> UIColor {
        return UIColor(hexString: "#74c8f6")!
    }
    
    class func primary2() -> UIColor {
        return UIColor(hexString: "#f5a623")!
    }
    
    class func primary3() -> UIColor {
        return UIColor(hexString: "#63c961")!
    }
    
    // MARK: - Text Color
    class func titleText() -> UIColor {
        return UIColor(hexString: "#4d5560")!
    }
    
    class func normalText() -> UIColor {
        return UIColor(hexString: "#000000")!
    }
    
    class func subtitle() -> UIColor {
        return UIColor(hexString: "#a9a9a9")!
    }
    
    class func ColorTextGreen() -> UIColor {
        return UIColor(hexString: "#63c961")!
    }
    
    class func ColorTextBlue() -> UIColor {
        return UIColor(hexString: "#5fc7ff")!
    }
    
    class func ColorTextOrange() -> UIColor {
        return UIColor(hexString: "#ff5721")!
    }
    
    // MARK: - Button Color
    class func success() -> UIColor {
        return UIColor(hexString: "#63c961")!
    }
    class func warning() -> UIColor {
        return UIColor(hexString: "#f5a623")!
    }
    class func danger() -> UIColor {
        return UIColor(hexString: "#f15642")!
    }
    class func CustomLightRed() -> UIColor {
        return UIColor(hexString: "#fbe9e7")!
    }


}
