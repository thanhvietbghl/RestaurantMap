//
//  NetworkMonitor.swift
//  Base_Movie
//
//  Created by Viet Phan on 24/03/2022.
//

import Foundation
import Network
import RxRelay

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    var networkStatus = BehaviorRelay<NWPath.Status>(value: .unsatisfied)
    var hasConnection: Bool {
        return networkStatus.value == .satisfied
    }
    
    private let monitor = NWPathMonitor()
    
    private init() { }
    
    func startListen() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            let status = path.status
            self.networkStatus.accept(status)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
