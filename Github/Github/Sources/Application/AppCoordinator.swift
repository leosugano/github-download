//
//  AppCoordinator.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Vars
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - ViewControllers
    var homeViewModel: HomeViewModel?

    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
       
    // MARK: - Routing
    func start() {
        goToHomeViewController()
    }
    
    func goToHomeViewController(homeViewModel: HomeViewModel = HomeViewModel()) {
        homeViewModel.coordinator = self
        self.homeViewModel = homeViewModel
        
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func goToDetailsViewController(detailViewModel: DetailViewModel = DetailViewModel(), _ character: CharacterDatasResponseModel?) {
        
        detailViewModel.coordinator = self
        detailViewModel.setCharacter(character)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func goToFilterViewController() {
        let filterViewModel = FilterViewModel()
        filterViewModel.coordinator = self
        
        let filterViewController = FilterViewController(viewModel: filterViewModel)
        
        self.navigationController.pushViewController(filterViewController, animated: true)
    }
    
    func popFilterViewWithValues(values: FilterSelectModel) {
        self.navigationController.popViewControllerWithHandler { 
            self.homeViewModel?.updateFilterValues(values)
            self.homeViewModel?.getDatas()
        }
    }
    
    func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
    
    func showAlert(message: String,
                   showPositiveButton: Bool = true,
                   titlePositiveButton: String = "alertYes".localized,
                   showNegativeButton: Bool = true,
                   _ completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController.createAlert(message: message,
                                                  showPositiveButton: showPositiveButton,
                                                  titlePositiveButton: titlePositiveButton,
                                                  showNegativeButton: showNegativeButton) {
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
