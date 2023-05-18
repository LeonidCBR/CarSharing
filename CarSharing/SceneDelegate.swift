//
//  SceneDelegate.swift
//  CarSharing
//
//  Created by Яна Латышева on 06.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let carsVM = CarsViewModel(carsharingProviders: [.cityDrive, .yandexDrive])
        window?.rootViewController = UINavigationController(rootViewController:
                                                                MapViewController(with: carsVM))
        window?.makeKeyAndVisible()
    }

}

