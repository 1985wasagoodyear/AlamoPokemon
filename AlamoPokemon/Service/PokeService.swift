//
//  PokeService.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation
import Alamofire

class PokeService {
    
    // MARK: - Properties
    
    let queue: DispatchQueue
    let decoder: JSONDecoder
    
    // MARK: - Initializers
    
    init(queue: DispatchQueue, decoder: JSONDecoder) {
        self.queue = queue
        self.decoder = decoder
    }
    
    convenience init() {
        self.init(queue: DispatchQueue.main,
                  decoder: JSONDecoder())
    }
    
    // MARK: - Network Access Methods
    func requestPokemon(_ request: PSMonRequest,
                        _ completion: @escaping (Pokemon?)->Void) {
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Pokemon.self, queue: queue, decoder: decoder) { (response: DataResponse<Pokemon, AFError>) in
                do {
                    let mon = try response.result.get()
                    completion(mon)
                }
                catch {
                    // TODO: - Handle some error here
                    completion(nil)
                }
        }
    }
    
    func fetchImage(_ request: PSImageRequest,
                    _ completion: @escaping (Data?)->Void) {
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseData(queue: queue) { (response) in
                // TODO: - Handle errors here
                completion(response.data)
        }
        
    }
    
}
