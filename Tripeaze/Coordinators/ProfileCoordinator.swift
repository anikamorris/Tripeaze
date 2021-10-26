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
    weak var parentCoordinator: MainCoordinator?
    
    //MARK: Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Methods
    func start() {
        let profileController = ProfileController()
        profileController.coordinator = self
        profileController.tabBarItem = UITabBarItem(title: "Profile",
                                                    image: UIImage(systemName: "person.circle"),
                                                    selectedImage: UIImage(systemName:  "person.circle.fill"))
        navigationController.pushViewController(profileController, animated: false)
    }
    
    func signOut() {
        FirebaseAuthManager().signOut()
        parentCoordinator?.signOut()
    }
}


