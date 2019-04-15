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
    
    let viewModel = RepositoryListViewModel()
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
