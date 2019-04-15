//
//  RepositoryListViewModel.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import Foundation

class RepositoryListViewModel {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var repositories = [RepositoryCellPresenter]()
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private var page: Int = 1
}

//-----------------------------------------------------------------------------
// MARK: - Public methods
//-----------------------------------------------------------------------------

extension RepositoryListViewModel {
    
    func update(completion: @escaping (() -> Void), failure: @escaping ((_ errorMessage: ServerBridgeErrorMessage) -> Void)) {
        
        page = 1
        
        ServerBridge.repositories(withPage: page, completion: { repositories in
            self.repositories = self.parseRepositoryCellPresenter(with: repositories)
            completion()
        }, failure: { errorMessage in
            failure(errorMessage)
        })
        
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Parser
//-----------------------------------------------------------------------------

extension RepositoryListViewModel {
    
    private func parseRepositoryCellPresenter(with repositories: [_JSON]) -> ([RepositoryCellPresenter]) {
        
        var presenters = [RepositoryCellPresenter]()
        
        repositories.forEach({ respository in
            if let repositoryName = respository["name"] as? String,
                let stars = respository["stargazers_count"] as? UInt32,
                let owner = respository["owner"] as? _JSON,
                let authorName = owner["login"] as? String,
                let authorPhotoURLString = owner["avatar_url"] as? String,
                let authorPhotoURL = URL(string: authorPhotoURLString) {
                
                let presenter = RepositoryCellPresenter(
                    repositoryName: repositoryName,
                    stars: stars,
                    authorName: authorName,
                    authorPhotoURL: authorPhotoURL)
                
                presenters.append(presenter)
            }
        })
        
        return presenters
    }
    
}
