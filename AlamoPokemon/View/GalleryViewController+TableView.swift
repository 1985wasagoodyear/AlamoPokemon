//
//  GalleryViewController+TableView.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

extension GalleryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return controller.mons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_ID,
                                                 for: indexPath)
        let row = indexPath.row
        let mon = controller.mons[row]
        cell.textLabel?.text = mon.name
        cell.imageView?.image = nil
        controller.fetchImage(for: row) { (data) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            cell.imageView?.image = image
            cell.setNeedsLayout()
        }
        return cell
    }
    
}

extension GalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        controller.modify(index: row)
    }
}
