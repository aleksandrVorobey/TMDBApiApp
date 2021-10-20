//
//  MainTabBarController.swift
//  Movies
//
//  Created by Александр Воробей on 17.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar() {
        let moviesViewController = createNavigationController(rootViewController: MovieViewController(), title: "Movies", image: "film.fill")
        let favoritesViewController = createNavigationController(rootViewController: FavoritesController().self, title: "Favorites", image: "star.fill")
        let settingsViewController = createNavigationController(rootViewController: SettingsController().self, title: "Settings", image: "gearshape.fill")
        
        viewControllers = [moviesViewController, favoritesViewController, settingsViewController]
    }
    
    func createNavigationController(rootViewController: UIViewController, title: String, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: image)
        return navigationVC
    }
    
    
}

