//
//  RepositoryListViewController.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet private weak var tableView: UITableView!
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let viewModel = RepositoryListViewModel()
    
    private let refreshControl = UIRefreshControl()
    private let cellIdentifier = String(describing: RepositoryCell.self)
}

//-----------------------------------------------------------------------------
// MARK: - View lifecycle
//-----------------------------------------------------------------------------

extension RepositoryListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension RepositoryListViewController {
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Load
//-----------------------------------------------------------------------------

extension RepositoryListViewController {
    
    private func load() {
        
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Update
//-----------------------------------------------------------------------------

extension RepositoryListViewController {
    
    @objc private func update() {
        
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - TableViewDataSource
//-----------------------------------------------------------------------------

extension RepositoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RepositoryCell
        
        cell.presenter = viewModel.repositories[indexPath.row]
        
        return cell
    }
}

//-----------------------------------------------------------------------------
// MARK: - TableViewDelegate
//-----------------------------------------------------------------------------

extension RepositoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
