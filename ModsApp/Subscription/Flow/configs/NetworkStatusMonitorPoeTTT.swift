//  Created by Melnykov Valerii on 14.07.2023
//

import Foundation
import Network
import UIKit

// APP REFACTORING

private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
    let poe1 = 4
    let poe2 = 6
    return Double(poe1 + poe2)
}

// APP REFACTORING

protocol NetworkStatusMonitorDelegatePoeTTT : AnyObject {
    func showBadMess()
    func internetOk()
}

class NetworkStatusMonitorPoeTTT {
    
    // APP REFACTORING

    private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
        let poe1 = 4
        let poe2 = 6
        return Double(poe1 + poe2)
    }

    // APP REFACTORING
    
    static let shared = NetworkStatusMonitorPoeTTT()

    private let queue = DispatchQueue.global()
    private let nwMonitor: NWPathMonitor
    
    weak var delegate : NetworkStatusMonitorDelegatePoeTTT?

    public private(set) var isNetworkAvailable: Bool = false {
        didSet {
            if !isNetworkAvailable {
                DispatchQueue.main.async {
                    print("No internet connection.")
                    self.delegate?.showBadMess()
                }
            } else {
                self.delegate?.internetOk()
                print("Internet connection is active.")
            }
        }
    }

    private init() {
        nwMonitor = NWPathMonitor()
    }

    func startMonitoring() {
        nwMonitor.start(queue: queue)
        nwMonitor.pathUpdateHandler = { path in
            self.isNetworkAvailable = path.status == .satisfied
        }
    }

    func stopMonitoring() {
        nwMonitor.cancel()
    }
}
