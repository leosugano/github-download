//
//  BaseViewController.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//
import SnapKit
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Constants
    var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = LoadingView(frame: view.frame)
    }
    
    // MARK: - Loading
    func showLoading(_ loading: Bool) {        
        guard let loadingView = loadingView else { return }
        
        loadingView.loadSpinner(loading)
        loadingView.removeFromSuperview()
        
        if loading {
            self.view.addSubview(loadingView)
        }
    }
}
