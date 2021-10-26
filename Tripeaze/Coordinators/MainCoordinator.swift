//
//  MainCoordinator.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator {
    
    //MARK: Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    //MARK: Init
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        super.init()
        navigationController.delegate = self
    }
    
    //MARK: Methods
    func start() {
        if FirebaseAuthManager().getCurrentUser() != nil {
            navigationController.pushViewController(mainTabBarController(), animated: false)
        } else {
            goToLandingController()
        }
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
    
    func goToHome() {
        navigationController.pushViewController(mainTabBarController(), animated: true)
    }
    
    func signOut() {
        childCoordinators = []
        navigationController.viewControllers = []
        navigationController.setNavigationBarHidden(false, animated: false)
        goToLandingController()
    }
    
    //MARK: Private
    private func goToLandingController() {
        let landingController = LandingController()
        landingController.coordinator = self
        navigationController.pushViewController(landingController, animated: false)
    }
    private func mainTabBarController() -> MainTabBarController {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        return mainTabBarController
    }
    
    private func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let profileController = fromViewController as? ProfileController {
            childDidFinish(profileController.coordinator )
        }
    }
}
