//
//  ImageServiceTests.swift
//  StargazersTests
//
//  Created by MacOS on 10/31/20.
//

import XCTest

class ImageServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidImageParsing() throws {
        
        // setup
        let expectation = XCTestExpectation(description: "Image downloaded")
        
        let httpService = HTTPServiceMock()
        httpService.jsonType = .ImageData
        
        let imageService = ImageService(httpService: httpService)
        
        let remoteDataPublisher = imageService.getImageFromUrl(url: "https://avatars0.githubusercontent.com/u/4901397?v=4")
            .sink(receiveCompletion: { completion in
                                
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
                
            }, receiveValue: { image in
                                
                let imageOriginal = UIImage(imageLiteralResourceName: "avatar-placeholder")
                XCTAssert(imageOriginal.pngData() == image.pngData())
            })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRetrieveRealImage() throws {
        
        // setup
        let expectation = XCTestExpectation(description: "Image downloaded")
        
        let httpService = HTTPService()
        
        let imageService = ImageService(httpService: httpService)
        
        let remoteDataPublisher = imageService.getImageFromUrl(url: "https://avatars0.githubusercontent.com/u/4189786?v=4")
            .sink(receiveCompletion: { completion in
                                
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
                
            }, receiveValue: { image in
                                                
                let imageOriginal = UIImage(named: "4189786.jpeg",
                                            in: Bundle(for: type(of:self)),
                                            compatibleWith: nil)
                
                XCTAssert(imageOriginal?.pngData() == image.pngData())
            })
        
        XCTAssertNotNil(remoteDataPublisher)
        wait(for: [expectation], timeout: 5.0)
    }
}
