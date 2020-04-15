//
//  GalleryControllerProtocol.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

typealias NetworkStatusChangeHandler = (Bool)->Void

protocol GalleryControllerProtocol {
    
    // MARK: - Default Setup
    
    var view: GalleryViewProtocol! { get }
    var mons: [Pokemon] { get }
    func start()
    func stop()
    
    // MARK: - Pokemon Service Accessors:
    
    func requestPokemon(_ query: String,
                        _ completion: @escaping ()->Void)
    func fetchImage(for index: Int,
                    _ completion: @escaping (Data?)->Void)
    
    // MARK: - Networking Accessors:
    
    func startMonitoringNetworkChanges(queue: DispatchQueue,
                                       allowsCellular: Bool,
                                       _ handler: @escaping NetworkStatusChangeHandler)
    func stopMonitoringNetworkChanges()
}

extension GalleryControllerProtocol {
    func stop() {
        view.stop()
    }
}
