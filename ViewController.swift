//
//  ViewController.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 30/09/23.
//

import UIKit

class ViewController: UIViewController {


    // MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func update(playerState: SPTAppRemotePlayerState) {
    }

    // MARK: - Actions

    // MARK: - Private Helpers
}

// MARK: Style & Layout
extension ViewController {

}

// MARK: - SPTAppRemoteDelegate
extension ViewController {
}

// MARK: - SPTAppRemotePlayerAPIDelegate
extension ViewController {
}

// MARK: - SPTSessionManagerDelegate
extension ViewController {
}

// MARK: - Networking
extension ViewController {

}

