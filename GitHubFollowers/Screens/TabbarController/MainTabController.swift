//
//  GFTabController.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 23/10/22.
//

import UIKit

class GFTabController: UITabBarController {

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = .systemGreen
        
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        viewControllers = [
            searchViewController(),
            favoritesVC()
        ]
    }
    
    // MARK: - Private methods

    private func searchViewController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Buscar"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    private func favoritesVC() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favoritos"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
}
