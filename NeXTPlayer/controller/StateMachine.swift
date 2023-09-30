//
//  StateMachine.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import Foundation
import Combine

class StateMachine {
    
    enum State {
        case start
        case configuring
        case loading
        case config
        case error
        case group
        case detail
    }
    
    enum Event {
        case startConfig
        case startGrouping
        case cancel
        case search
        case success
        case failure
        case onDetail
    }
    
    private(set) var state: State {
        didSet { stateSubject.send(self.state) }
    }
    private let stateSubject: PassthroughSubject<State, Never>
    let statePublisher: AnyPublisher<State, Never>
    
    init(state: State) {
        self.state = state
        self.stateSubject = PassthroughSubject<State, Never>()
        self.statePublisher = self.stateSubject.eraseToAnyPublisher()
    }
}


// MARK: - State changes
extension StateMachine {
    
    @discardableResult func tryEvent(_ event: Event) -> Bool {
        guard let state = nextState(for: event) else {
            return false
        }
        
        self.state = state
        return true
    }
    
    private func nextState(for event: Event) -> State? {
        switch state {
        case .start:
            switch event {
            case .startConfig: return .configuring
            case .cancel, .search, .onDetail, .success, .startGrouping, .failure: return nil
            }
        case .configuring:
            switch event {
            case .search: return .loading
            case .startConfig: return nil
            case .cancel: return .start
            case .success, .onDetail,.startGrouping, .failure: return nil
            }
        case .loading:
            switch event {
            case .search, .cancel, .onDetail, .startGrouping,  .startConfig: return nil
            case .success: return .config
            case .failure: return .error
            }
        case .config:
            switch event {
            case .startConfig: return .configuring
            case .cancel, .startGrouping, .onDetail,.search, .success, .failure: return nil
            }
        case .group:
            switch event {
            case .startGrouping: return .configuring
            case .cancel, .search, .onDetail, .success, .startConfig, .failure: return nil
            }
        case .detail:
            switch event {
            case .onDetail: return .configuring
            case .cancel, .search, .success, .startConfig, .failure: return nil
            case .startGrouping: return .configuring
            }
        case .error:
            switch event {
            case .startConfig: return .configuring
            case .cancel, .search, .success, .onDetail, .startGrouping, .failure: return nil
            }
        }
    }
    
}
