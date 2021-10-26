//
//  TabBarCoordinator.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class ProfileCoordinator: NSObject, Coordinator {
    
    //MARK: Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //MARK: Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Methods
    func start() {
        navigationController.delegate = self
        let profileController = ProfileController()
        profileController.coordinator = self
        profileController.tabBarItem = UITabBarItem(title: "Profile",
                                                    image: UIImage(systemName: "person.circle"),
                                                    selectedImage: UIImage(systemName:  "person.circle.fill"))
        navigationController.pushViewController(profileController, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension ProfileCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let destinationsController = fromViewController as? DestinationsController {
            childDidFinish(destinationsController.coordinator )
        }
    }
}
