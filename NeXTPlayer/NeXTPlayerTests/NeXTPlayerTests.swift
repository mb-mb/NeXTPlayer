//
//  NeXTPlayerTests.swift
//  NeXTPlayerTests
//
//  Created by marcelo bianchi on 03/10/23.
//

import XCTest
import Combine

@testable import NeXTPlayer

final class NeXTPlayerTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testfetchArtists() throws {
        
        let vm = LocalSongsForAlbumListViewModel(albumID: 1)
        let expectation = XCTestExpectation(description: "Fetch local artists")
        // Perform the publisher operation
        let publisher = vm.fetchLocalArtists2()
        
        publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Successful completion
                    expectation.fulfill()
                case .failure(let error):
                    // Handle the failure case, optionally assert expectations
                    XCTFail("Fetch local artists failed with error: \(error)")
                }
            }, receiveValue: { artists in
                // Handle the received value (artists), optionally assert expectations
                XCTAssertGreaterThanOrEqual(artists.count, 0, "There should be at least one artist")
            })
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled (or timeout)
        wait(for: [expectation], timeout: 10.0) // Adjust the timeout as needed
    }

    func testfetchSongs() throws {
        
        let vm = LocalSongsForAlbumListViewModel(albumID: 1)
        let expectation = XCTestExpectation(description: "Fetch local artists")
        // Perform the publisher operation
        let publisher = vm.fetchLocalSongs2()
        
        publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Successful completion
                    expectation.fulfill()
                case .failure(let error):
                    // Handle the failure case, optionally assert expectations
                    XCTFail("Fetch local artists failed with error: \(error)")
                }
            }, receiveValue: { songs in
                // Handle the received value (artists), optionally assert expectations
                print("songs count: \(songs.count)")
                XCTAssertGreaterThanOrEqual(songs.count, 1, "There should be at least one artist")
            })
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled (or timeout)
        wait(for: [expectation], timeout: 10.0) // Adjust the timeout as needed
    }

    
}
