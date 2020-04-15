//
//  GalleryViewController+GalleryView.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

extension GalleryViewController: GalleryViewProtocol {
    
    /// will begin handling network outages
    func start() {
        let handler: (Bool)->Void = { [weak self] (available) in
            if !available {
                self?.showAlert(text: "It seems you've lost internet.",
                                message: "Please reconnect to WiFi to continue.")
            }
        }
        controller.startMonitoringNetworkChanges(queue: .main,
                                                 allowsCellular: false,
                                                 handler)
    }
    
    /// stop listening for network outages
    func stop() {
        controller.stopMonitoringNetworkChanges()
    }
    
    // MARK: - UI Update Methods
    
    func updateData() {
        let rows = [IndexPath(row: controller.mons.count - 1, section: 0)]
        tableView.insertRows(at: rows, with: .automatic)
    }
    
    func displayError() {
        showAlert(text: "Some error occurred.", message: "Please try again")
    }
}

extension GalleryViewController {
    func showAlert(text: String, message: String? = nil) {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

