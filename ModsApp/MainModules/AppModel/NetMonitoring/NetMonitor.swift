//
//  NetMonitor.swift
//  ModsApp
//
//
//

import Foundation
import Network

final class NetMonitor {
    
    static let shared = NetMonitor()
    
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    
    func startToMonitoring() {
        struct DefaultStruct {
            static let noname = "string"
        }
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            
            if path.status == .satisfied {
                print("We're connected!")
                // post connected notification
            } else {
                print("No connection.")
                // post disconnected notification
            }
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "NetMonitor")
        monitor.start(queue: queue)
    }
    
    func stopToMonitoring() {
        struct DefaultStruct {
            static let noname = "string"
        }
        monitor.cancel()
    }
}
