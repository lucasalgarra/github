//
//  LoadMoreView.swift
//  GitHub
//
//  Created by Lucas Algarra on 16/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import UIKit

protocol LoadMoreViewDelegate: class {
    func loadMoreViewDidTapReload()
}

class LoadMoreView: XIBView {
    
    enum Style {
        case loading
        case needReload
    }

    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var reloadButton: UIButton!

    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var style: LoadMoreView.Style = .loading {
        didSet {
            load()
        }
    }
    weak var delegate: LoadMoreViewDelegate?
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        load()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        load()
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension LoadMoreView {
    
    private func setup() {
        setupReloadButton()
    }
    
    private func setupReloadButton() {
        reloadButton.setTitleColor(.buttonDarkTitle, for: .normal)
        reloadButton.setTitle("LoadMoreViewReloadButton".localizable, for: .normal)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Load
//-----------------------------------------------------------------------------

extension LoadMoreView {
    
    private func load() {
        activityIndicatorView.isHidden = style != .loading
        reloadButton.isHidden = style != .needReload
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Actions
//-----------------------------------------------------------------------------

extension LoadMoreView {
    
    @IBAction private func reloadTap(_ sender: Any) {
        delegate?.loadMoreViewDidTapReload()
    }
    
}
