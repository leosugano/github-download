//
//  LoadingView.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - Vars
    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Inits
    init(color: UIColor = UIColor(named: "MainColor") ?? .blue) {
        super.init(frame: CGRect.getRectForApp())
        addSubviews(color: color)
        setBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews(color: UIColor(named: "MainColor") ?? .blue)
    }
    
    // MARK: - Set Constraints
    private func addSubviews(color: UIColor) {
        spinner.color = color
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
