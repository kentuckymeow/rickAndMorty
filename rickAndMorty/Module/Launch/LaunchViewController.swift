//
//  LaunchViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import UIKit

final class LaunchViewController: UIViewController {
    enum Event {
        case launchComlpete
    }
    
    var didSendEventHandler: ((LaunchViewController.Event )-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handler()
    }
    
    private func setupUI() {
        view.backgroundColor = .blue
    }
    
    private func handler() {
        didSendEventHandler?(.launchComlpete)
    }
    
   
}
