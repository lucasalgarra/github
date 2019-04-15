//
//  RepositoryCellPresenter.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import Foundation

class RepositoryCellPresenter: RepositoryCellPresentable {
    
    var name: String
    var stars: Float
    var authorName: String
    var authorPhotoURL: URL
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(name: String,
         stars: Float,
         authorName: String,
         authorPhotoURL: URL) {
        
        self.name = name
        self.stars = stars
        self.authorName = authorName
        self.authorPhotoURL = authorPhotoURL
    }
}
