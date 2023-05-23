//
//  BaseCoordinator.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 04/04/23.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
