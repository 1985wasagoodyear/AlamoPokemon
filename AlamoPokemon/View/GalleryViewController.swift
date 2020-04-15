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

    enum Constants {
        static let reuseId = "cellReuseID"
    }
    
    // MARK: - Properties
    
    var controller: GalleryControllerProtocol!
    
    // MARK: - UI Properties

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseId)
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        return table
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    
    private func setupConstraints() {
        let sConst = [
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let tConst = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
