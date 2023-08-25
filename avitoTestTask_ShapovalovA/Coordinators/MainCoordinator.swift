//
//  MainCoordinator.swift
//  avitoTestTask_ShapovalovA
//
//  Created by Aleksandr Shapovalov on 25/08/23.
//

import UIKit

class MainCoordinator: Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainVC = MainViewController()
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: false)
    }

    func showDetail(for product: Product) {
        let detailVC = DetailViewController()
        detailVC.product = product
        navigationController.pushViewController(detailVC, animated: true)
    }
}
