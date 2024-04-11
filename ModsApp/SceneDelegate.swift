

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    
    var window: UIWindow?
    static weak var shared: SceneDelegate?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        Self.shared = self
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
//        IAPManagerPoeTTT.shared.validateSubscriptions(productIdentifiers: [SubscriptionKey.mainSubscriptionID, SubscriptionKey.unlockFuncSubscriptionID, SubscriptionKey.unlockContentSubscriptionID]) { userHaveSub in
//            if (userHaveSub[SubscriptionKey.mainSubscriptionID] ?? false) {
                let unsubscribedVC = LoadingBlueViewController()
                unsubscribedVC.modalPresentationStyle = .fullScreen
                let navVC = UINavigationController(rootViewController: unsubscribedVC)
                navVC.setNavigationBarHidden(true, animated: false)
                navVC.navigationBar.isHidden = true
                self.window?.rootViewController = navVC
                self.window?.makeKeyAndVisible()
//            }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                    let unsubscribedVC = PremiumMainControllerPoeTTT()
//                    unsubscribedVC.modalPresentationStyle = .fullScreen
//                    self.window?.rootViewController = unsubscribedVC
//                    self.window?.makeKeyAndVisible()
//                })
//            }
//        }
    }
    
    func lets_loadBloodyApp() -> Void {
        struct DefaultStruct {
            static let noname = "string"
        }
        let tabBarVC = LoadingBlueViewController()
        let navVC = UINavigationController(rootViewController: tabBarVC)
        navVC.setNavigationBarHidden(true, animated: false)
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    func lets_loadBloodySubscription() -> Void {
        struct DefaultStruct {
            static let noname = "string"
        }
        let tabBarVC = UIViewController()
        let navVC = UINavigationController(rootViewController: tabBarVC)
        navVC.setNavigationBarHidden(true, animated: false)
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

}
