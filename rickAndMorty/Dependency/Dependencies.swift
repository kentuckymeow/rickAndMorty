//
//  Dependencies.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import Foundation

protocol IDependencies {
    var moduleContainer: IModuleContainer { get }
    var networkService: IHTTPClient { get }
    var episodeService: IEpisodeService { get }
}

final class Dependencies: IDependencies {
    lazy var moduleContainer: IModuleContainer = ModuleContainer(self)
    lazy var networkService: IHTTPClient = HTTPClient()
    lazy var episodeService: IEpisodeService = EpisodeService(self)
}
