//
//  RepositoryListViewModelTest.swift
//  GitHubTests
//
//  Created by Lucas Algarra on 16/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import XCTest
@testable import GitHub

class RepositoryListViewModelTest: XCTestCase {
    
    let repositoryListViewModel = RepositoryListViewModel()

    func testParseRepository() {
        
        let json: _JSON = [
            "name": "Repository name",
            "stargazers_count": UInt32(100),
            "owner": [
                "login": "username",
                "avatar_url": "https://pbs.twimg.com/profile_images/1021521280946892801/4Ti_k27z_400x400.jpg"
            ],
        ]
        
        let repositories = repositoryListViewModel.parseRepositoryCellPresenter(with: [json])
        
        XCTAssertTrue(repositories.count == 1)
    }

}
