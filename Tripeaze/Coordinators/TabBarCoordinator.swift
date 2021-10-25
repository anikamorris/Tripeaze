//
//  TabBarCoordinator.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    
    //MARK: Properties
    var childCoordinators: [Coordinator] = []
    var tabBarController = UITabBarController()
        
    //MARK: Init
    init(window: UIWindow) {
        window.rootViewController = tabBarController
        tabBarController.tabBar.tintColor = .primaryColor
    }
    
    // MARK: Methods
    func start() {
        let profileController = ProfileController()
        profileController.coordinator = self
        profileController.tabBarItem = UITabBarItem(title: "Profile",
                                                    image: UIImage(systemName: "person.circle"),
                                                    selectedImage: UIImage(systemName:  "person.circle.fill"))
        
        let destinationsController = DestinationsController()
        destinationsController.coordinator = self
        destinationsController.tabBarItem = UITabBarItem(title: "Destinations",
                                                         image: UIImage(systemName: "photo"),
                                                         selectedImage: UIImage(systemName:  "photo.fill"))
        
        tabBarController.viewControllers = [destinationsController, profileController]
        tabBarController.selectedViewController = profileController
    }
}
