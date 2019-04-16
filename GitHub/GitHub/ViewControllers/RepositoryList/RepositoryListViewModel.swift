//
//  RepositoryListViewModel.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import Foundation
import Alamofire

class RepositoryListViewModel {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    private(set) var repositories = [RepositoryCellPresenter]()
    private(set) var isLoadingMore = false
    private(set) var hasMore = false
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private var updateDataRequest: DataRequest?
    private var loadMoreDataRequest: DataRequest?
    
    private var page: Int = 1
    private var limit: Int = 10
}

//-----------------------------------------------------------------------------
// MARK: - Public methods
//-----------------------------------------------------------------------------

extension RepositoryListViewModel {
    
    func update(completion: @escaping (() -> Void), failure: @escaping ((_ errorMessage: ServerBridgeErrorMessage?) -> Void)) {
        
        updateDataRequest?.cancel()
        
        updateDataRequest = ServerBridge.repositories(withPage: 1, limit: limit, completion: { repositories, totalCount in
            self.repositories = self.parseRepositoryCellPresenter(with: repositories)
            self.page = 1
            self.hasMore = self.repositories.count < totalCount
            self.updateDataRequest = nil
            completion()
        }, failure: { errorMessage in
            self.updateDataRequest = nil
            failure(errorMessage)
        })
        
    }
    
    func loadMore(completion: @escaping (() -> Void), failure: @escaping ((_ errorMessage: ServerBridgeErrorMessage?) -> Void)) {
        
        loadMoreDataRequest?.cancel()
        
        isLoadingMore = true
        
        loadMoreDataRequest = ServerBridge.repositories(withPage: page + 1, limit: limit, completion: { repositories, totalCount in
            self.repositories += self.parseRepositoryCellPresenter(with: repositories)
            self.page += 1
            self.hasMore = self.repositories.count < totalCount
            self.isLoadingMore = false
            self.loadMoreDataRequest = nil
            completion()
        }, failure: { errorMessage in
            self.isLoadingMore = false
            self.loadMoreDataRequest = nil
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
