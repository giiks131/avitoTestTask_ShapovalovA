//
//  AppCoordinator.swift
//  avitoTestTask_ShapovalovA
//
//  Created by Aleksandr Shapovalov on 25/08/23.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
