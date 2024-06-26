//
//  SceneDelegate.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UITabBarControllerDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let vocaBookViewController = UINavigationController(rootViewController: VocaBookViewController())
        let studyViewController = UINavigationController(rootViewController: StudyViewController())
        let reportViewController = UINavigationController(rootViewController: ReportViewController())
        let userViewController = UINavigationController(rootViewController: UserViewController())
        
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.setViewControllers([vocaBookViewController,
                                             studyViewController,
                                             reportViewController,
                                             userViewController], animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].title = "단어장"
            items[1].title = "학습하기"
            items[2].title = "통계"
            items[3].title = "사용자"
            items[0].image = UIImage.book
            items[1].image = UIImage.pencil
            items[2].image = UIImage.pieChart
            items[3].image = UIImage.person
        }
        
        tabBarController.tabBar.backgroundColor = .evBackground
        tabBarController.tabBar.tintColor = .evText
        tabBarController.tabBar.unselectedItemTintColor = .gray50
        tabBarController.selectedIndex = 1
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController,
            let reportVC = navController.viewControllers.first as? ReportViewController {
            reportVC.reloadData()
            print(#function)
        }
        
        if let navController = viewController as? UINavigationController,
            let studyVC = navController.viewControllers.first as? StudyViewController {
            studyVC.bind()
            print(#function)
        }
        
        if let navController = viewController as? UINavigationController,
            let userVC = navController.viewControllers.first as? UserViewController {
            userVC.setProgressBar()
            print(#function)
        }

    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

