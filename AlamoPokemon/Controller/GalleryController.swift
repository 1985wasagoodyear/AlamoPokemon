//
//  GalleryController.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation
import Alamofire

class GalleryController: GalleryControllerProtocol {
    
    // MARK: - Properties
    
    let reachability: NetworkReachabilityManager
    let service: PokeService
    var mons: [Pokemon] = []
    
    var view: GalleryViewProtocol!
    
    // MARK: - Initializers
    
    init(_ service: PokeService = PokeService()) {
        guard let reachability = NetworkReachabilityManager(host: "www.apple.com") else {
            fatalError("Could not create NetworkReachabilityManager instance")
        }
        self.reachability = reachability
        self.service = service
    }
    
    // MARK: - Default Setup
    
    func start() {
        view = GalleryViewController()
        view.controller = self
        view.start()
    }
    
    deinit { }
    
    // MARK: - Networking Accessors:
    
    func requestPokemon(_ query: String,
                        _ completion: @escaping ()->Void) {
        let request = PSMonRequest(query: query)
        service.requestPokemon(request) { [weak self] (mon) in
            guard let self = self else { return }
            if let mon = mon {
                self.mons.append(mon)
                completion()
                self.view.updateData()
            }
            else {
                completion()
                self.view.displayError()
            }
        }
    }
    
    func fetchImage(for index: Int,
                    _ completion: @escaping (Data?)->Void) {
        let request = PSImageRequest(url: mons[index].imageURL)
        service.fetchImage(request) { (data) in
            completion(data)
        }
    }
    
    // MARK: - Networking Accessors:
    
    func startMonitoringNetworkChanges(queue: DispatchQueue,
                                       allowsCellular: Bool = false,
                                       _ handler: @escaping NetworkStatusChangeHandler) {
        reachability.startListening(onQueue: queue) { (status) in
            switch status {
            case .unknown:
                fallthrough
            case .notReachable:
                handler(false)
            case .reachable(let c):
                switch c {
                case .cellular:
                    if !allowsCellular { handler(false) }
                    else { fallthrough }
                case .ethernetOrWiFi:
                    handler(true)
                }
            }
        }
    }
    
    /// This must always be called sometime after using `startMonitoringNetworkChanges:queue:allowsCellular:handler`.
    func stopMonitoringNetworkChanges() {
        reachability.stopListening()
    }
    
}


