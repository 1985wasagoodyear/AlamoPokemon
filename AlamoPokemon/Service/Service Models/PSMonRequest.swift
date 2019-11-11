//
//  PSMonRequest.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Alamofire

struct PSMonRequest {
    let request: String
    init(query: String) {
        request = PSAPI.pokemon + query
    }
}

extension PSMonRequest: URLConvertible {
    func asURL() throws -> URL {
        return URL(string: request)!
    }
}
