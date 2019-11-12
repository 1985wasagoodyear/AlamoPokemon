//
//  Pokemon+CoreDataClass.swift
//  
//
//  Created by K Y on 11/11/19.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "NSManagedObjectContext")!
}

enum DecodableCoreDataError: Error {
    case missingContext
}

@objc(Pokemon)
public class Pokemon: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case spritesContainer = "sprites"
        case imageURL = "front_default"
        case id = "id"
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context) else {
            throw DecodableCoreDataError.missingContext
        }
        super.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        pokeId = Int64(try container.decode(Int.self, forKey: .id))
        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.self,
                                                             forKey: .spritesContainer)
        imageURL = try spritesContainer.decode(String.self,
                                               forKey: .imageURL)
    }
}
