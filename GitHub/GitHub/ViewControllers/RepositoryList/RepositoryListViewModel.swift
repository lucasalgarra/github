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
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init() {
        
        for i in 0..<10 {
            let presenter1 = RepositoryCellPresenter(
                repositoryName: "Projeto \(i)",
                stars: 0.5,
                authorName: "Lucas Algarra",
                authorPhotoURL: URL(string: "https://pbs.twimg.com/profile_images/1021521280946892801/4Ti_k27z_400x400.jpg")!)
            repositories.append(presenter1)
        }
    }
}
