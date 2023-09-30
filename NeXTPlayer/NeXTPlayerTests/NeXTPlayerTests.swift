//
//  NeXTPlayerTests.swift
//  NeXTPlayerTests
//
//  Created by marcelo bianchi on 17/10/21.
//


import XCTest
@testable import NeXTPlayer

class NeXTPlayerTests: XCTestCase {


    func testViewModelInitialState() {
        let viewModel = ContentViewModel(stateMachine: StateMachine(state: StateMachine.State.start))
        XCTAssertTrue(viewModel.state == .start)
    }

    func testViewModelStateIsConfig() {
        // given
        let viewModel = ContentViewModel(stateMachine: StateMachine(state: StateMachine.State.start))
        
        // when
        viewModel.state = .config
        
        // then
        XCTAssertTrue(viewModel.state == .config)
    }

}
