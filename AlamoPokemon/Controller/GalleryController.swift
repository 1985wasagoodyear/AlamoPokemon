//
//  GalleryController.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class GalleryController: NSObject, GalleryControllerProtocol {
    
    // MARK: - Properties
    
    let reachability: NetworkReachabilityManager
    let service: PokeService
    var mons: [Pokemon] = []
    let manager: CoreDataManager
    lazy var frc: NSFetchedResultsController<Pokemon> = {
        let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        let idSort = NSSortDescriptor(key: "pokeId", ascending: true)
        request.sortDescriptors = [idSort]
        let moc = manager.mainContext
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    var view: GalleryViewProtocol!
    
    // MARK: - Initializers
    
    override init() {
        reachability = NetworkReachabilityManager(host: "www.apple.com")!
        manager = CoreDataManager()
        let decoder = JSONDecoder()
        decoder.userInfo[.context] = manager.mainContext
        service = PokeService(queue: .main, decoder: decoder)
        super.init()
    }
    
    // MARK: - Default Setup
    
    func start() {
        view = GalleryViewController()
        view.controller = self
        view.start()
        do {
            try frc.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    deinit {
        
    }
    
    // MARK: - Networking Accessors:
    
    func requestPokemon(_ query: String,
                        _ completion: @escaping ()->Void) {
        let request = PSMonRequest(query: query)
        service.requestPokemon(request) { [weak self] (mon) in
            guard let self = self else { return }
            if let mon = mon {
                self.mons.append(mon)
            }
            else {
                self.view.displayError()
            }
            completion()
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


