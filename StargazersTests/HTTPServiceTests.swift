//
//  HTTPServiceTests.swift
//  StargazersTests
//
//  Created by MacOS on 10/31/20.
//

import XCTest

@testable import Stargazers

class HTTPServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHTTPRequestSuccess() throws {
        
        // setup
        let endpoint = "https://api.github.com/repos/andreeweb/heapheap/stargazers"
        let expectation = XCTestExpectation(description: "Download json from \(endpoint)")
        
        let httpService = HTTPService()
        
        let remoteDataPublisher = httpService.makeHttpRequest(endpoint: endpoint)
            .sink(receiveCompletion: { completion in
                                
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
                
            }, receiveValue: { httpRespose in
                
                let mockJson = """
                [{"login":"baiyunping333","id":4901397,"node_id":"MDQ6VXNlcjQ5MDEzOTc=","avatar_url":"https://avatars0.githubusercontent.com/u/4901397?v=4","gravatar_id":"","url":"https://api.github.com/users/baiyunping333","html_url":"https://github.com/baiyunping333","followers_url":"https://api.github.com/users/baiyunping333/followers","following_url":"https://api.github.com/users/baiyunping333/following{/other_user}","gists_url":"https://api.github.com/users/baiyunping333/gists{/gist_id}","starred_url":"https://api.github.com/users/baiyunping333/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/baiyunping333/subscriptions","organizations_url":"https://api.github.com/users/baiyunping333/orgs","repos_url":"https://api.github.com/users/baiyunping333/repos","events_url":"https://api.github.com/users/baiyunping333/events{/privacy}","received_events_url":"https://api.github.com/users/baiyunping333/received_events","type":"User","site_admin":false}]
                """.data(using: .utf8)
                
                XCTAssertNotNil(httpRespose.data)
                XCTAssert(httpRespose.data == mockJson)
            })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
        
    func testHTTPRequestError() throws {
        
        // setup
        continueAfterFailure = false
        let endpoint = "https:>>www.reddit.com/r/spacex/top.json"
        let expectation = XCTestExpectation(description: "Download json from \(endpoint)")
        let httpService = HTTPService()
        
        let remoteDataPublisher = httpService.makeHttpRequest(endpoint: endpoint)
            .sink(receiveCompletion: { completion in
                                
                switch completion {
                case .finished: XCTFail()
                case .failure(let error):
                    if case HTTPServiceError.HTTPEndpointNotValid = error {
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
