//
//  BaseCoordinator.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
