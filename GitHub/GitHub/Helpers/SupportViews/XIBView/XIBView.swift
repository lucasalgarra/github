//
//  XIBView.swift
//  GitHub
//
//  Created by Lucas Algarra on 16/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import UIKit

import UIKit
import SnapKit

open class XIBView: UIView {
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet weak var view: UIView!
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXIB()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXIB()
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension XIBView {
    
    private func setupXIB() {
        let anyClass = type(of: self)
        let className = String(describing: anyClass)
        Bundle(for: anyClass).loadNibNamed(className, owner: self, options: nil)
        
        backgroundColor = .clear
        
        setupView()
    }
    
    private func setupView() {
        insertSubview(view, at: 0)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.clipsToBounds = false
    }
    
}
