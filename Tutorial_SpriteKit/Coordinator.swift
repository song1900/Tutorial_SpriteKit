//
//  Coordinator.swift
//  Tutorial_SpliteKit
//
//  Created by 송우진 on 2021/02/16.
//

import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootVC = RootViewController()
        let navigationRootVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navigationRootVC
        window.makeKeyAndVisible()
    }
}
