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
}

//-----------------------------------------------------------------------------
// MARK: - Repositories
//-----------------------------------------------------------------------------

extension ServerBridge {
    
    static func repositories(
        withPage page: Int,
        limit: Int,
        completion: @escaping ((_ repositories: [_JSON], _ totalCount: Int) -> Void),
        failure: @escaping ((_ errorMessage: ServerBridgeErrorMessage) -> Void)) -> (DataRequest?) {
        
        let url: String = "\(serverAddress)/search/repositories"
        
        let parameters = [
            "q": "language:swift",
            "sort": "stars",
            "page": "\(page)",
            "per_page": "\(limit)"
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
                    let repositories = json["items"] as? [_JSON],
                    let totalCount = json["total_count"] as? Int else {
                        DispatchQueue.main.async {
                            let errorMessage = ServerBridgeErrorMessage.parseErrorMessage()
                            failure(errorMessage)
                        }
                        return
                }
                
                DispatchQueue.main.async {
                    completion(repositories, totalCount)
                }
            case .failure(let error):
                print(error)
                let errorMessage = ServerBridgeErrorMessage(
                    code: response.response?.statusCode,
                    title: nil,
                    message: error.localizedDescription)
                DispatchQueue.main.async {
                    failure(errorMessage)
                }
            }
        }
        
        return request
    }
    
}
