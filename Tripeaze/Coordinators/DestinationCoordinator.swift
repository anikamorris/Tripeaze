//
//  DestinationCoordinator.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class DestinationCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let destinationsController = DestinationsController()
        destinationsController.coordinator = self
        destinationsController.tabBarItem = UITabBarItem(title: "Destinations",
                                                    image: UIImage(systemName: "photo"),
                                                    selectedImage: UIImage(systemName:  "photo.fill"))
        navigationController.pushViewController(destinationsController, animated: false)
    }
    
    func addDestination() {
        let newDestinationController = NewDestinationController()
        newDestinationController.coordinator = self
        navigationController.pushViewController(newDestinationController, animated: true)
    }
    
    func saveDestination(_ destination: Destination) {
        let destinationsController = navigationController.viewControllers[0] as? DestinationsController
        destinationsController?.destinations.append(destination)
        navigationController.popViewController(animated: true)
    }
}
