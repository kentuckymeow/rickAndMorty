//
//  EpisodesRouter.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit

protocol EpisodesRouteProtocol {
    func showCharacterDetails(for index: Int)
}
class EpisodesRouter {
    let appCoordator: AppCoordinator
    
    init(appCoordator: AppCoordinator) {
        self.appCoordator = appCoordator
    }
}

extension EpisodesRouter: EpisodesRouteProtocol {
    func showCharacterDetails(for index: Int) {
        print("Router method called for index: \(index)")
        appCoordator.showCharacterFlow()
    }
}


