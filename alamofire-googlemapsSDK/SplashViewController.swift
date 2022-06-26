//
//  SplashViewController.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 24.06.2022.
//

import UIKit
import Foundation

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.performNeededSegue()
        })
    }
    
    private func performNeededSegue() {
        let tabBarVC = UITabBarController()
        let postcodeVC = UINavigationController(rootViewController: PostcodesViewController())
        let mapVC = UINavigationController(rootViewController: MapViewController())
        tabBarVC.setViewControllers([postcodeVC, mapVC], animated: true)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let titles = ["Postcodes", "Map"]
        
        for item in 0..<items.count {
            items[item].title = titles[item]
        }
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.yellow
        tabBarVC.tabBar.standardAppearance = appearance;
        tabBarVC.tabBar.scrollEdgeAppearance = tabBarVC.tabBar.standardAppearance
        tabBarVC.tabBar.isTranslucent = false
        tabBarVC.tabBar.tintColor = UIColor.black
        tabBarVC.modalTransitionStyle = .crossDissolve
        tabBarVC.modalPresentationStyle = .overFullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
}

