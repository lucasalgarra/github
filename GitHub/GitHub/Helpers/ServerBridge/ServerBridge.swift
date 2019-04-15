//
//  ServerBridge.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import Foundation
import Alamofire

typealias _JSON = [String: Any]

class ServerBridge {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private static let serverAddress = "https://api.github.com"
    private static let repositoriesLimit: Int = 10
}

//-----------------------------------------------------------------------------
// MARK: - Repositories
//-----------------------------------------------------------------------------

extension ServerBridge {
    
    static func repositories(
        withPage page: Int,
        completion: @escaping ((_ repositories: [_JSON]) -> Void),
        failure: @escaping ((_ errorMessage: ServerBridgeErrorMessage) -> Void)) {
        
        let url: String = "\(serverAddress)/search/repositories"
        
        let parameters = [
            "q": "language:swift",
            "sort": "stars",
            "page": "\(page)",
            "per_page": "\(repositoriesLimit)"
        ]
        
        let request = Alamofire.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: nil)
        
        request.validate().responseJSON { response in
            
            switch response.result {
            case .success(let data):
                guard let json = data as? _JSON,
                    let repositories = json["items"] as? [_JSON] else {
                        failure(ServerBridgeErrorMessage.parseErrorMessage())
                        return
                }
                
                completion(repositories)
            case .failure(let error):
                print(error)
                let errorMessage = ServerBridgeErrorMessage(
                    code: response.response?.statusCode,
                    title: nil,
                    message: error.localizedDescription)
                failure(errorMessage)
            }
        }
    }
    
}
