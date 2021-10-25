//
//  Coordinator.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
