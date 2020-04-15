//
//  GalleryViewProtocol.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

protocol GalleryViewProtocol: UIViewController {
    
    var controller: GalleryControllerProtocol! { get set }
    
    // MARK: - View Lifecycle Methods
    
    func start()
    func stop()
    
    // MARK: - Data/Change Feedback Methods
    
    func updateData()
    func displayError()
}
