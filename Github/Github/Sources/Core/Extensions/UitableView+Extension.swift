//
//  UitableView+Extension.swift
//  Github
//
//  Created by Leonardo Sugano on 23/05/23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, indexPath: IndexPath) -> T {
        self.register(cell: type)
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T {
            return cell
        }
        
        return T()
    }

    func reloadData(_ completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    // MARK: - Register cell
    private func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
}
