//
//  GroupCoordinator.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/27/21.
//

import Foundation
import UIKit

class GroupCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let groupController = GroupController()
        groupController.coordinator = self
        groupController.tabBarItem = UITabBarItem(title: "My Groups",
                                                    image: UIImage(systemName: "person.3"),
                                                    selectedImage: UIImage(systemName:  "person.3.fill"))
        navigationController.pushViewController(groupController, animated: false)
    }
}
