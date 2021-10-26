//
//  MainTabBarControllerViewController.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    //MARK: Properties
    let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    let destinationCoordinator = DestinationCoordinator(navigationController: UINavigationController())
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        profileCoordinator.start()
        destinationCoordinator.start()
        
        viewControllers = [destinationCoordinator.navigationController,
                           profileCoordinator.navigationController
        ]
    }
}
