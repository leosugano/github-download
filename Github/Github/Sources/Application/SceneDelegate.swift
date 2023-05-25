import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        for argument in CommandLine.arguments where argument == "-uitesting" {
            return
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.startApp()
        
        let navigationController = GithubNavigationViewController()
        navigationController.setNavigationBarHidden(false, animated: false)
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()

        window.rootViewController = navigationController
        self.window = window

        window.makeKeyAndVisible()
    }
    
    private func startApp() {
    #if !targetEnvironment(simulator)
        ReachabilitySingleton.shared.startNotifier()
    #endif
    }
}
