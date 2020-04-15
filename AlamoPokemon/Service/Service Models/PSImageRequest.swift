//
//  PSImageRequest.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Alamofire

struct PSImageRequest {
    let url: String
}

extension PSImageRequest: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: url) else {
            throw NSError(domain: "bad url",
                          code: 1,
                          userInfo: ["url": url])
        }
        return url
    }
}
