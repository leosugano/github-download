//
//  Reachbility.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
//

import Foundation

class ReachabilitySingleton {
    
    // MARK: - Constants
    static let shared = ReachabilitySingleton()
    
    // MARK: - Vars
    var internetStatusManager = Reachability()

    // MARK: - Init
    private init() {}
    
    // MARK: - Func start notification
    func startNotifier() {
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged(_:)), name: .reachabilityChanged, object: internetStatusManager)
        
        do {
            try internetStatusManager?.startNotifier()
            
        } catch {
            print(error)
        }
    }
     
    // MARK: - Internet Changed
    @objc func internetChanged(_ note: Notification) {
        guard let reachability = note.object as? Reachability else {
            return
        }
        
        UserDefaults.standard.removeObject(forKey: Keys.userDefaultNoInternet)

        if reachability.connection == .none {
            UserDefaults.standard.set(true, forKey: Keys.userDefaultNoInternet)
        }
    }
        
    // MARK: - Check internet connection
    func checkInternetConnection() {
        
        internetStatusManager?.whenReachable = { reachability in
            UserDefaults.standard.removeObject(forKey: Keys.userDefaultNoInternet)

            if reachability.connection == .none {
                UserDefaults.standard.set(true, forKey: Keys.userDefaultNoInternet)
            }
        }
        
        internetStatusManager?.whenUnreachable = { reachability in
            if reachability.connection == .none {
                UserDefaults.standard.set(true, forKey: Keys.userDefaultNoInternet)
            }
        }
    }
}
