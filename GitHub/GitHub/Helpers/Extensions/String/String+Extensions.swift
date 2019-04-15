//
//  String+Extensions.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import Foundation

//-----------------------------------------------------------------------------
// MARK: - Localizable
//-----------------------------------------------------------------------------

extension String {
    
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
