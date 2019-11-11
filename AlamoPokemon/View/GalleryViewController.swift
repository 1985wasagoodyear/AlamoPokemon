//
//  GalleryViewController.swift
//  AlamoPokemon
//
//  Created by K Y on 11/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit
import MBProgressHUD

class GalleryViewController: UIViewController {

    // MARK: - Constants
    
    let REUSE_ID = "reuseID"
    
    // MARK: - Properties
    
    var controller: GalleryControllerProtocol!
    
    // MARK: - UI Properties

    lazy var searchBar: UISearchBar = {
       let s = UISearchBar(frame: .zero)
        s.delegate = self
        s.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(s)
        return s
    }()
    
    lazy var tableView: UITableView = {
       let t = UITableView(frame: .zero, style: .plain)
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: REUSE_ID)
        t.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(t)
        return t
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    
    private func setupConstraints() {
        let s = searchBar
        let t = tableView
        let v = view!
        let sConst = [
            s.topAnchor.constraint(equalTo: v.layoutMarginsGuide.topAnchor),
            s.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            s.trailingAnchor.constraint(equalTo: v.trailingAnchor)
        ]
        let tConst = [
            t.topAnchor.constraint(equalTo: s.bottomAnchor),
            t.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            t.trailingAnchor.constraint(equalTo: v.trailingAnchor),
            t.bottomAnchor.constraint(equalTo: v.bottomAnchor)
        ]
        NSLayoutConstraint.activate(sConst + tConst)
    }
    
    // MARK: - Adjust UI Methods
    
    func showLoadingUI() {
        MBProgressHUD.showAdded(to: view, animated: true)
        searchBar.isUserInteractionEnabled = false
    }
    
    func hideLoadingUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            guard let self = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
            self.searchBar.isUserInteractionEnabled = true
        }
    }

}


extension GalleryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        view.endEditing(true)
        showLoadingUI()
        controller.requestPokemon(query) { [weak self] in
            self?.hideLoadingUI()
        }
    }
}


