//
//  Configurations.swift
//  template
//
//  Created by Melnykov Valerii on 14.07.2023.
//

import Foundation

// APP REFACTORING

private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
    let poe1 = 4
    let poe2 = 6
    return Double(poe1 + poe2)
}

// APP REFACTORING

enum Configurations {
    static let adjustToken = "hfg1t85ufqbk"
    
    static let pushwooshToken = "22192-19DD0"
    static let pushwooshAppName = "Noname.digital"
    
    static let termsLink: String = "https://www.google.com"
    static let policyLink: String = "https://www.google.com"
    
    static let mainSubscriptionID = "main_sub"
    static let mainSubscriptionPushTag = "MainSubscription"
    //to remove adds
    static let unlockContentSubscriptionID = "unlockOne"
    static let unlockContentSubscriptionPushTag = "SecondSubscription"
    static let unlockFuncSubscriptionID = "unlockTwo"
    static let unlockFuncSubscriptionPushTag = "SecondSubscription"
    static let unlockerThreeSubscriptionID = "unlockThree"
    static let unlockerThreeSubscriptionPushTag = "FourSubscription"
    
    static let subscriptionSharedSecret = "253336a4821b43d0af174241a9a85f90"
}


enum ConfigurationMediaSubPoeTTT {
    static let nameFileVideoForPhone = "phone"
    static let nameFileVideoForPad = "pad"
    static let videoFileType = "mp4"
}
