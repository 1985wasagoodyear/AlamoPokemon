//
//  GalleryController+ NSFetchedResultsControllerDelegate.swift
//  AlamoPokemon
//
//  Created by K Y on 11/11/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation
import CoreData

extension GalleryController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
            case .delete:
                if let row = indexPath?.row {
                    view.deleteData(at: row)
                }
            case .insert:
                view.insertData(at: mons.count)
            case .update:
                let row = indexPath?.row ?? 0
                view.updateData(at: row)
            case .move:
                print("other handling for moving data around")
            @unknown default:
                print("unknown case handling here")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view.endUpdates()
    }
}
