//
//  Pokemon.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case spritesContainer = "sprites"
        case imageURL = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.self,
                                                         forKey: .spritesContainer)
        imageURL = try spritesContainer.decode(String.self,
                                           forKey: .imageURL)
    }
}
