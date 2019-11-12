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
        guard let indexPath = indexPath else { return }
        print(indexPath)
        switch type {
            case .delete:
                view.deleteData(at: indexPath.row)
            case .insert:
                view.insertData(at: indexPath.row)
            default:
                print("other handling")
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view.endUpdates()
    }
}
