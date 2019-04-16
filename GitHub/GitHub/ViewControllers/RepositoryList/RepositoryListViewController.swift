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
    @IBOutlet private var loadMoreView: LoadMoreView!
    
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
        setupLoadMoreView()
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
    
    private func setupLoadMoreView() {
        loadMoreView.delegate = self
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
        
        if !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
            if tableView.contentOffset.y < 0 {
                let contentOffset = CGPoint(x: 0, y: -(refreshControl.frame.height + tableViewInset))
                tableView.setContentOffset(contentOffset, animated: true)
            }
        }
        
        viewModel.update(completion: {
            self.didUpdate()
            self.tableView.tableFooterView = self.viewModel.hasMore ? self.loadMoreView : nil
        }, failure: { errorMessage in
            
            let alertController = UIAlertController(
                title: errorMessage?.title,
                message: errorMessage?.message,
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "AlertOkButton".localizable, style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: {
                self.didUpdate()
            })
            
        })
        
    }
    
    private func loadMore(isUserAction: Bool = false) {
        viewModel.loadMore(completion: {
            self.didUpdate()
            self.tableView.tableFooterView = self.viewModel.hasMore ? self.loadMoreView : nil
        }, failure: { errorMessage in
            
            self.loadMoreView.style = .needReload
            
            if isUserAction, let errorMessage = errorMessage {
                let alertController = UIAlertController(
                    title: errorMessage.title,
                    message: errorMessage.message,
                    preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "AlertOkButton".localizable, style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: {
                    self.didUpdate()
                })
            } else {
                self.didUpdate()
            }
            
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

//-----------------------------------------------------------------------------
// MARK: - ScrollViewDelegate
//-----------------------------------------------------------------------------

extension RepositoryListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let lastCell = tableView.visibleCells.last,
            let indexPath = tableView.indexPath(for: lastCell) {
            
            if indexPath.row < viewModel.repositories.count - 1 {
                loadMoreView.style = .loading
            }
            
            if !viewModel.isLoadingMore,
                viewModel.hasMore,
                loadMoreView.style == .loading,
                tableView.tableFooterView == loadMoreView,
                indexPath.row == viewModel.repositories.count - 1 {
                loadMore()
            }
            
            
        }
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - LoadMoreViewDelegate
//-----------------------------------------------------------------------------

extension RepositoryListViewController: LoadMoreViewDelegate {
    func loadMoreViewDidTapReload() {
        loadMoreView.style = .loading
        loadMore(isUserAction: true)
    }
}
