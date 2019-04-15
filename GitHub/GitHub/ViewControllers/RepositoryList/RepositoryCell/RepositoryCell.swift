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
    var stars: UInt32 { get }
    var authorName: String { get }
    var authorPhotoURL: URL { get }
}

class RepositoryCell: UITableViewCell {
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var starCountLabel: UILabel!
    @IBOutlet private weak var starIconImageView: UIImageView!
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
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let userIconImage = UIImage(named: "UserIcon")?.maskImage(with: .darkText)
    
    private lazy var starNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()
    
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
        setupRepositoryNameLabel()
        setupStarIconImageView()
        setupStarCountLabel()
        setupAuthorNameLabel()
        setupAuthorPhotoImageView()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupCardView() {
        cardView.layer.cornerRadius = 8
        cardView.layer.masksToBounds = true
    }
    
    private func setupRepositoryNameLabel() {
        repositoryNameLabel.textColor = .darkText
    }
    
    private func setupStarIconImageView() {
        starIconImageView.image = UIImage(named: "StarIcon")?.maskImage(with: .normalText)
    }
    
    private func setupStarCountLabel() {
        starCountLabel.textColor = .normalText
    }
    
    private func setupAuthorNameLabel() {
        authorNameLabel.textColor = .normalText
    }
    
    private func setupAuthorPhotoImageView() {
        authorPhotoImageView.backgroundColor = .defaultBackgroundColor
        authorPhotoImageView.layer.cornerRadius = authorPhotoImageView.frame.height / 2
        authorPhotoImageView.layer.masksToBounds = true
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Load
//-----------------------------------------------------------------------------

extension RepositoryCell {
    
    private func load() {
        loadRepositoryNameLabel()
        loadStarCountLabel()
        loadAuthorNameLabel()
        loadAuthorPhotoImageView()
    }
    
    private func loadRepositoryNameLabel() {
        repositoryNameLabel.text = presenter?.repositoryName
    }
    
    private func loadStarCountLabel() {
        
        guard let stars = presenter?.stars else {
            starCountLabel.text = nil
            starIconImageView.isHidden = true
            return
        }
        
        if stars >= 1_000 {
            let kStars = Double(stars) / 1_000
            if let starsText = starNumberFormatter.string(from: NSNumber.init(value: kStars)) {
                starCountLabel.text = starsText + "k"
            }

        } else {
            starCountLabel.text = starNumberFormatter.string(from: NSNumber.init(value: stars))
        }
        
        
        starIconImageView.isHidden = false
    }
    
    private func loadAuthorNameLabel() {
        authorNameLabel.text = presenter?.authorName
    }
    
    private func loadAuthorPhotoImageView() {
        authorPhotoImageView.image = userIconImage
        
        guard let imageURL = presenter?.authorPhotoURL else { return }
        
        UIImage.download(imageWithURL: imageURL) { (image, url) in
            if imageURL == url {
                self.authorPhotoImageView.image = image
            }
        }
    }
}
