
import SwiftyDropbox
import FirebaseCore
import IQKeyboardManagerSwift
import UIKit
import Pushwoosh
import Adjust
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static weak var shared: AppDelegate?
    private let networkMonitoring = NetMonitor.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        struct DefaultStruct {
            static let noname = "string"
        }
//        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback)
//            try AVAudioSession.sharedInstance().setActive(true)
//        } catch {
//            print("Error setting up AVAudioSession: \(error.localizedDescription)")
//        }
        
        Self.shared = self
        
        FirebaseApp.configure()
        
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.enable = true
        networkMonitoring.startToMonitoring()
        NetworkStatusMonitorPoeTTT.shared.startMonitoring()
        ThirdPartyServicesManagerPoeTTT.shared.initializeAdjust()
        ThirdPartyServicesManagerPoeTTT.shared.initializePushwoosh(delegate: self)
        //ThirdPartyServicesManager.shared.makeATT()
//        ThirdPartyServicesManagerPoeTTT.shared.initializeInApps()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        lets_setupBloodyTabBarchik()
        
        DropboxClientsManager.setupWithAppKey(KeysForDropBoks.apiLink)
        
        return true
    }
    
    
    
    private func lets_setupBloodyTabBarchik() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let appearance = UITabBarItem.appearance()
        var tabbarFont = UIFont()
        if UIDevice.current.userInterfaceIdiom == .pad {
            tabbarFont = UIFont(name: "VT323-Regular", size: 12)!
        } else {
            tabbarFont = UIFont(name: "VT323-Regular", size: 10)!
        }
        let attributes = [NSAttributedString.Key.font: tabbarFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributes2 = [NSAttributedString.Key.font: tabbarFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .selected)
        appearance.setTitleTextAttributes(attributes2 as [NSAttributedString.Key : Any], for: .normal)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        struct DefaultStruct {
            static let noname = "string"
        }
        return DropboxClientsManager.handleRedirectURL(url) { authResult in
            guard let authResult = authResult else { return }
            switch authResult {
            case .success(let token):
                print("Success! User is logged into Dropbox with token: \(token)")
            case .cancel:
                print("User canceld OAuth flow.")
            case .error(let error, let description):
                print("Error \(error): \(String(describing: description))")
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        struct DefaultStruct {
            static let noname = "string"
        }
    }
}

typealias AppDel = AppDelegate
extension AppDel : PWMessagingDelegate {
    
    //handle token received from APNS
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Adjust.setDeviceToken(deviceToken)
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    //handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        struct DefaultStruct {
            static let noname = "string"
        }
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    //this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        struct DefaultStruct {
            static let noname = "string"
        }
        print("onMessageReceived: ", message.payload?.description ?? "error")
    }
    
    //this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        struct DefaultStruct {
            static let noname = "string"
        }
        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}
