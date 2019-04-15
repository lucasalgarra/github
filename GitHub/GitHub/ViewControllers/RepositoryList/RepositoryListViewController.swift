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
    private var rowHeights = [Int: CGFloat]()
    private let tableViewInset: CGFloat = 10
}

//-----------------------------------------------------------------------------
// MARK: - View lifecycle
//-----------------------------------------------------------------------------

extension RepositoryListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        update()
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension RepositoryListViewController {
    
    private func setup() {
        
        setupView()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupView() {
        view.backgroundColor = .defaultBackgroundColor
    }
    
    private func setupNavigationBar() {
        title = "RepositoryListTitle".localizable
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        tableView.contentInset = UIEdgeInsets(top: tableViewInset, left: 0, bottom: tableViewInset, right: 0)
        
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
        
        self.refreshControl.beginRefreshing()
        if self.tableView.contentOffset.y < 0 {
            let contentOffset = CGPoint(x: 0, y: -(self.refreshControl.frame.height + tableViewInset))
            self.tableView.setContentOffset(contentOffset, animated: true)
        }
        
        viewModel.update(completion: {
            self.didUpdate()
        }, failure: { errorMessage in
            
            let alertController = UIAlertController(
                title: errorMessage.title,
                message: errorMessage.message,
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "AlertOkButton".localizable, style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            self.didUpdate()
        })
        
    }
    
    private func didUpdate() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        
        tableView.reloadData()
    }
}

//-----------------------------------------------------------------------------
// MARK: - TableViewDataSource
//-----------------------------------------------------------------------------

extension RepositoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeights[indexPath.row] ?? 100
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.superview?.bringSubviewToFront(cell)
        
        rowHeights[indexPath.row] = cell.frame.height
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        rowHeights[indexPath.row] = cell.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
