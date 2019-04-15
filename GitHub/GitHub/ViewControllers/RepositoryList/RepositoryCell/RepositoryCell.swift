//
//  RepositoryCell.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import UIKit

protocol RepositoryCellPresentable {
    var repositoryName: String { get }
    var stars: Float { get }
    var authorName: String { get }
    var authorPhotoURL: URL { get }
}

class RepositoryCell: UITableViewCell {
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var authorPhotoImageView: UIImageView!

    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var presenter: RepositoryCellPresenter? {
        didSet {
            load()
        }
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Override
    //-----------------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension RepositoryCell {
    
    private func setup() {
        setupView()
        setupCardView()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupCardView() {
        cardView.layer.cornerRadius = 8
        cardView.layer.masksToBounds = true
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Load
//-----------------------------------------------------------------------------

extension RepositoryCell {
    
    private func load() {
        self.repositoryNameLabel.text = presenter?.repositoryName
    }
    
}
