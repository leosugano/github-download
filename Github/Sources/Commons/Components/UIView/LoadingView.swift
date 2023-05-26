//
//  LoadingView.swift
//  Github
//
//  Created by Leonardo Sugano on 05/05/23.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - Vars
    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
    
    // MARK: - Set Constraints
    private func addSubviews() {
        spinner.color = .black
        self.addSubview(spinner)
        spinner.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }

    private func setBackgroundColor() {
        self.backgroundColor = .white
    }
    
    func loadSpinner(_ load: Bool) {
        spinner.stopAnimating()
        
        if load {
            spinner.startAnimating()
        }
    }

}
