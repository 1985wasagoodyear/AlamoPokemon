//
//  CoreDataManager+Trainer.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import CoreData

private let entityName = "Trainer"

extension CoreDataManager {
    
    func loadTrainer(_ completion: @escaping (Trainer?)->Void) {
        let context = mainContext
        let desc = NSEntityDescription.entity(forEntityName: entityName,
                                              in: context)!
        context.perform {
            let request = NSFetchRequest<Trainer>()
            request.entity = desc
            request.fetchLimit = 1
            let results = try! context.fetch(request)
            completion(results.first)
        }
    }
    
    func loadTrainerSynchronously() -> Trainer? {
        let context = mainContext
        let desc = NSEntityDescription.entity(forEntityName: entityName,
                                              in: context)!
        var trainer: Trainer! = nil
        context.performAndWait {
            let request = NSFetchRequest<Trainer>()
            request.entity = desc
            request.fetchLimit = 1
            let results = try! context.fetch(request)
            trainer = results.first
        }
        return trainer
    }
    
    func saveTrainer(name: String, image: String) -> Trainer {
        
        let context = mainContext
        let desc = NSEntityDescription.entity(forEntityName: entityName,
                                              in: context)!
        var trainer: Trainer! = nil
        context.performAndWait {
            trainer = Trainer(entity: desc, insertInto: context)
            trainer.name = name
            trainer.image = image
            self.saveMain()
        }
        return trainer!
    }
    
    func delete(_ trainer: Trainer) {
        mainContext.delete(trainer)
        saveMain()
    }
}
