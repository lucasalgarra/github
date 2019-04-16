//
//  RepositoryCellTest.swift
//  GitHubTests
//
//  Created by Lucas Algarra on 16/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import XCTest
@testable import GitHub

class RepositoryCellTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoad() {
        
        let repositoryName = "Repositório"
        let stars: UInt32 = 100
        let authorName = "Autor"
        let authorPhotoURLString = "https://pbs.twimg.com/profile_images/1021521280946892801/4Ti_k27z_400x400.jpg"
        guard let authorPhotoURL = URL(string: authorPhotoURLString) else { return }
        
        let presenter = GitHub.RepositoryCellPresenter(
            repositoryName: repositoryName,
            stars: stars,
            authorName: authorName,
            authorPhotoURL: authorPhotoURL)
        
        let xib = UINib(nibName: "RepositoryCell", bundle: nil)
        let views = xib.instantiate(withOwner: self, options: nil)
        guard let cell = views.first as? GitHub.RepositoryCell else {
            XCTFail("Can not initialize RepositoryCell")
            return
        }
        
        cell.presenter = presenter
        
        XCTAssertTrue(cell.repositoryNameLabel.text == repositoryName)
        XCTAssertTrue(cell.starCountLabel.text == "100")
        XCTAssertTrue(cell.authorNameLabel.text == authorName)

        presenter.stars = 1533
        cell.presenter = presenter
        XCTAssertTrue(cell.starCountLabel.text == "1,5k")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
