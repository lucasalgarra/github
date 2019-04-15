//
//  ServerBridgeErrorMessage.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import Foundation

class ServerBridgeErrorMessage {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var code: Int?
    var title: String?
    var message: String?
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(code: Int? = nil,
         title: String? = nil,
         message: String? = nil) {
        self.code = code
        self.title = title
        self.message = message
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public static methods
//-----------------------------------------------------------------------------

extension ServerBridgeErrorMessage {
    
    static func parseErrorMessage() -> ServerBridgeErrorMessage {
        return ServerBridgeErrorMessage(
            code: nil,
            title: "ServerBridgeErrorMessageParseTitle".localizable,
            message: "ServerBridgeErrorMessageParseMessage".localizable)
    }
    
}
