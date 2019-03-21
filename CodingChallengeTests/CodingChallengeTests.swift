/
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by mac on 3/19/19.
//  Copyright © 2019 mac. All rights reserved.
//

import XCTest
@testable import CodingChallenge

class CodingChallengeTests: XCTestCase {
    
    //state any variables used for test
    var viewModel: ViewModel!
    //var app = XCUIApplication()
    //var searchTableViewCell: SearchTableViewCell!
    
    override func setUp() {
        //initialize any objects that you may need for testing
        super.setUp()
        // continueAfterFailure = false
        //  app.launch()
        viewModel = ViewModel()
        //  searchTableViewCell = SearchTableViewCell()
        
    }
    
    override func tearDown() {
        // de init or reset variables to initial state for each function
        viewModel = nil
        super.tearDown()
    }
    
    func testContentCount() {
        //AAA - Arrange, Activate, Assert
        
        //1. Arrange
        viewModel.artistLimit = 0
        
        //2. Activate
        viewModel.resetLimits()
        
        //3. Asserts
        XCTAssertEqual(viewModel.artistLimit, 5)
    }
    
    func testAlbumCount() {
        //AAA - Arrange, Activate, Assert
        
        //1. Arrange
        viewModel.albumLimit = 7
        
        //2. Activate
        viewModel.updateLimits()
        
        //3. Asserts
        XCTAssertEqual(viewModel.albumLimit, 12)
    }
    
    func testServiceCall() {
        
        //1. Arrange
        var myAlbums = [Album]()
        
        //expectations - to wait for async call
        let promise = expectation(description: "receiving content..")
        
        //2. Activate
        ContentService.shared.getAlbums(search: "Snoop", limit: 10) { albums in
            
            myAlbums = albums
            promise.fulfill()
        }
        
        //set expectation wait time - in seconds
        waitForExpectations(timeout: 3, handler: nil)
        
        //3. Assert
        XCTAssertTrue(myAlbums.count > 0)
        XCTAssertEqual(myAlbums.count, 10)
        
        
        self.measure {
            viewModel.getContent(with: "Kanye")
        }
    }
    
    //func testlabelInSearchViewController(){
    //  let label = app.staticTexts["Artist"]
    //XCTAssertEqual(label.exists, true)
    //}
    //    func testUpdatedData(){
    //        var myartists = [Artist]()
    //
    //        let prom = expectation(description: "update data")
    //
    //        ContentService.shared.getArtists(search: "Snoop", limit: 10) { artist in
    //            myartists = artist
    //            prom.fulfill()
    //        }
    //        waitForExpectations(timeout: 3, handler: nil)
    //
    //        XCTAssertEqual(myartists.count , 0)
    //
    //        self.measure {
    //            viewModel.getContent(with: "Katty")
    //        }
    //    }
}
