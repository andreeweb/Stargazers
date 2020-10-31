//
//  GitHubServiceTests.swift
//  StargazersTests
//
//  Created by MacOS on 10/31/20.
//

import XCTest

@testable import Stargazers

class GitHubServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParsingValidJson() throws {
        
        // setup
        let expectation = XCTestExpectation(description: "Stargazers download, correct json")
        
        let httpService = HTTPServiceMock()
        
        let gitHubService = GitHubService(httpService: httpService)
        
        let remoteDataPublisher = gitHubService.getStargazersForRepositoryOwner(repository: "heapheap", owner: "andreeweb")
            .sink(receiveCompletion: { completion in
                                
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
                
            }, receiveValue: { stargazers in
                                
                XCTAssertNotNil(stargazers)
                
                guard (stargazers as Any) is [Stargazer] else {
                    XCTFail("This method should return an array")
                    return
                }
                
                let stargazer = stargazers[0];
                
                XCTAssert(stargazer.id == 4901397)
                XCTAssert(stargazer.node_id == "MDQ6VXNlcjQ5MDEzOTc=")
                XCTAssert(stargazer.type == "User")
            })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testParsingWrongJson() throws {
        
        // setup
        let expectation = XCTestExpectation(description: "Stargazers download, wrong json")

        let httpService = HTTPServiceMock()
        httpService.jsonType = .InvalidJson
        
        let gitHubService = GitHubService(httpService: httpService)
        
        let remoteDataPublisher = gitHubService.getStargazersForRepositoryOwner(repository: "heapheap", owner: "andreeweb")
            .sink(receiveCompletion: { completion in
                                
                switch completion {
                case .finished: XCTFail()
                case .failure(let error):
                    if case GitHubServiceError.CannotRetrieveStargazers = error {
                        expectation.fulfill()
                    }else{
                        XCTFail()
                    }
                }
                
            }, receiveValue: { _ in })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRepositoryDoesNotExist() throws {
        
        // setup
        let expectation = XCTestExpectation(description: "Stargazers download, wrong json")

        let httpService = HTTPService()
        
        let gitHubService = GitHubService(httpService: httpService)
        
        let remoteDataPublisher = gitHubService.getStargazersForRepositoryOwner(repository: "fake", owner: "andreeweb")
            .sink(receiveCompletion: { completion in
                                
                switch completion {
                case .finished: XCTFail()
                case .failure(let error):
                    if case GitHubServiceError.CannotRetrieveStargazers = error {
                        expectation.fulfill()
                    }else{
                        XCTFail()
                    }
                }
                
            }, receiveValue: { _ in })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
}
