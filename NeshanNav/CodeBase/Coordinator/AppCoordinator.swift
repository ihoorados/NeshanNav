//
//  AppCoordinator.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        let viewController = rootViewController()
       // navigationController.viewControllers = [viewController]
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func rootViewController() -> UIViewController {
        // Create Map View VC
        let rootVC = MapView()
        return rootVC
    }
    
    private func onComplete() {
        // TODO: Complete/Initiate Process here
    }
    
}
