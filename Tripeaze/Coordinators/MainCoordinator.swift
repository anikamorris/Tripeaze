//
//  MainCoordinator.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    //MARK: Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    //MARK: Init
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }
    
    //MARK: Methods
    func start() {
        let landingController = LandingController()
        landingController.coordinator = self
        navigationController.pushViewController(landingController, animated: false)
    }
    
    func goToLogin() {
        let loginController = LoginController()
        loginController.coordinator = self
        navigationController.pushViewController(loginController, animated: true)
    }
    
    func goToSignUp() {
        let signUpController = SignUpController()
        signUpController.coordinator = self
        navigationController.pushViewController(signUpController, animated: true)
    }
}
