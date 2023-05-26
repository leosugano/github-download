//
//  AppCoordinator.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Vars
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
       
    // MARK: - Routing
    func start() {
        goToHomeViewController()
    }
    
    func goToHomeViewController(homeViewModel: HomeViewModelProvider = HomeViewModel()) {
        homeViewModel.setCoordinator(coordinator: self)
        
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func goToDetailsViewController(detailViewModel: UserDetailViewModelProvider = UserDetailViewModel(),
                                   _ userName: String?) {
        
        detailViewModel.setCoordinator(coordinator: self)
        detailViewModel.setUserName(userName: userName)
        let detailViewController = UserDetailViewController(viewModel: detailViewModel)
        
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func goToSearchViewController(searchViewModel: SearchViewModelProvider = SearchViewModel()) {
        searchViewModel.setCoordinator(coordinator: self)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        
        self.navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func openUserURL(url: String?) {
        guard let url = url else { return }
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
    func showAlert(message: String,
                   titlePositiveButton: String = "",
                   _ completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController.createAlert(message: message,
                                                  titlePositiveButton: titlePositiveButton) {
            completion?()
        }
        self.navigationController.present(alert, animated: true)
    }
    
    func showErrorView(_ message: String?,
                       showTryAgainButton: Bool,
                       completion: (() -> Void)? = nil) {
        let errorView = ErrorView()
        errorView.setupErrorView(message: message, showTryAgain: showTryAgainButton, completionHandler: {
            completion?()
        })
        
        if let viewControler = self.navigationController.topViewController, !viewControler.view.subviews.contains(errorView) {
            
            viewControler.view.subviews.forEach { view in
                view.isHidden = true
            }
            
            DispatchQueue.main.async {
                viewControler.view.addSubview(errorView)
                viewControler.view.bringSubviewToFront(errorView)
                
                viewControler.view.subviews.forEach { view in
                    view.isHidden = false
                }
            }
        }
    }
    
    func dismissErrorView() {
        if let viewController = self.navigationController.topViewController {
            for views in viewController.view.subviews {
                if let errorView = views as? ErrorView {
                    errorView.removeFromSuperview()
                }
            }
        }
    }
}
