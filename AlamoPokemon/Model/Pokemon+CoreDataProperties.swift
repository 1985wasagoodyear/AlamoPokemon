//
//  Pokemon+CoreDataProperties.swift
//  
//
//  Created by K Y on 11/11/19.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var name: String
    @NSManaged public var imageURL: String
    @NSManaged public var pokeId: Int64

}
