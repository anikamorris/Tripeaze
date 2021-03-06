//
//  MainTabBarControllerViewController.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    //MARK: Properties
    weak var coordinator: MainCoordinator?
    let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    let destinationCoordinator = DestinationCoordinator(navigationController: UINavigationController())
    let groupCoordinator = GroupCoordinator(navigationController: UINavigationController())
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator?.childCoordinators.append(profileCoordinator)
        coordinator?.childCoordinators.append(destinationCoordinator)
        coordinator?.childCoordinators.append(groupCoordinator)
        
        profileCoordinator.start()
        destinationCoordinator.start()
        groupCoordinator.start()
        
        viewControllers = [destinationCoordinator.navigationController,
                           profileCoordinator.navigationController,
                           groupCoordinator.navigationController
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        profileCoordinator.parentCoordinator = self.coordinator
    }
}
