//
//  UIColor+Extensions.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import UIKit

extension UIColor {
    
    //-----------------------------------------------------------------------------
    // MARK: - Background colors
    //-----------------------------------------------------------------------------
    
    public static var defaultBackgroundColor: UIColor {
        return UIColor.init(white: 0.95, alpha: 1)
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Text colors
    //-----------------------------------------------------------------------------
    
    public static var darkText: UIColor {
        return UIColor.init(white: 0.2, alpha: 1)
    }
    
    public static var normalText: UIColor {
        return UIColor.init(white: 0.4, alpha: 1)
    }
    
}
