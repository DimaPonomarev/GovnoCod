//
//  ServicesManager.swift
//  template
//
//  Created by Melnykov Valerii on 14.07.2023.
//

import Foundation
import UIKit
import Adjust
import Pushwoosh
import AppTrackingTransparency
import AdSupport

// APP REFACTORING

private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
    let poe1 = 4
    let poe2 = 6
    return Double(poe1 + poe2)
}

// APP REFACTORING

class ThirdPartyServicesManagerPoeTTT {
    
    // APP REFACTORING

    private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
        let poe1 = 4
        let poe2 = 6
        return Double(poe1 + poe2)
    }

    // APP REFACTORING
    
    static let shared = ThirdPartyServicesManagerPoeTTT()
    
    func initializeAdjust() {
        let yourAppToken = Configurations.adjustToken
        #if DEBUG
        let environment = (ADJEnvironmentSandbox as? String)!
        #else
        let environment = (ADJEnvironmentProduction as? String)!
        #endif
        let adjustConfig = ADJConfig(appToken: yourAppToken, environment: environment)
        
        adjustConfig?.logLevel = ADJLogLevelVerbose

        Adjust.appDidLaunch(adjustConfig)
    }
    
    func initializePushwoosh(delegate: PWMessagingDelegate) {
        //set custom delegate for push handling, in our case AppDelegate
        Pushwoosh.sharedInstance().delegate = delegate;
        PushNotificationManager.initialize(withAppCode: Configurations.pushwooshToken, appName: Configurations.pushwooshAppName)
        PWInAppManager.shared().resetBusinessCasesFrequencyCapping()
        PWGDPRManager.shared().showGDPRDeletionUI()
        Pushwoosh.sharedInstance().registerForPushNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
    func initializeInApps(){
        IAPManagerPoeTTT.shared.loadProductsFunc()
        IAPManagerPoeTTT.shared.completeAllTransactionsFunc()
    }
    
    
    func makeATT() {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("Authorized")
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
                        print("Пользователь разрешил доступ. IDFA: ", idfa)
                        let authorizationStatus = Adjust.appTrackingAuthorizationStatus()
                        Adjust.updateConversionValue(Int(authorizationStatus))
                        Adjust.checkForNewAttStatus()
                        print(ASIdentifierManager.shared().advertisingIdentifier)
                    case .denied:
                        print("Denied")
                    case .notDetermined:
                        print("Not Determined")
                    case .restricted:
                        print("Restricted")
                    @unknown default:
                        print("Unknown")
                    }
                }
        }
    }
}

