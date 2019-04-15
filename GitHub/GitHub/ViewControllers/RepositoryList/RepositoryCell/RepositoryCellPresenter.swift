//
//  RepositoryCellPresenter.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import Foundation

class RepositoryCellPresenter: RepositoryCellPresentable {
    
    var repositoryName: String
    var stars: UInt32
    var authorName: String
    var authorPhotoURL: URL
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(repositoryName: String,
         stars: UInt32,
         authorName: String,
         authorPhotoURL: URL) {
        
        self.repositoryName = repositoryName
        self.stars = stars
        self.authorName = authorName
        self.authorPhotoURL = authorPhotoURL
    }
}
