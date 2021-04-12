//
//  NetworkingInstructor.swift
//  TestTask
//
//  Created by Ruslan Khanov on 12.04.2021.
//

import Network

enum NetworkStatus {
    case connected
    case noConnection
}

class NetworkStatusInstructor {
    
    static let publicInstructor = NetworkStatusInstructor()
        
    var status: NetworkStatus {
        monitor.currentPath.status == .satisfied ? .connected : .noConnection
    }
    
    private let monitor = NWPathMonitor()

    private init() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}

