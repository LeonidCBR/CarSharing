//
//  SceneDelegate.swift
//  CarSharing
//
//  Created by Яна Латышева on 06.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let carsVM = CarsViewModel()
        let mapViewController = MapViewController(with: carsVM)
        let mainController = UINavigationController(rootViewController: mapViewController)
        window?.rootViewController = mainController
        window?.makeKeyAndVisible()
    }

}
