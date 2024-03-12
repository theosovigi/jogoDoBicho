//
//  TabBarNavigator.swift


import UIKit

class TabBarNavigator: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().tintColor = .yellow
        UITabBar.appearance().backgroundColor = .black
        
        
        let homeVC = HomeVC()
        buildConfig(homeVC, title: "Home")

        let zooVC = ZooVC()
        let zooNavigation = UINavigationController(rootViewController: zooVC)
        buildConfig(zooNavigation, title: "Zoo")
        
        let myFotoVC = MyFotoVC()
        let myFotoNavigation = UINavigationController(rootViewController: myFotoVC)
        buildConfig(myFotoNavigation, title: "My Foto")

        let profileVC = ProfileVC()
        buildConfig(profileVC, title: "Profile")

        let myWork = MyWorkVC()
        buildConfig(myWork, title: "My Work")
        
        
        viewControllers = [homeVC,zooNavigation,myFotoNavigation,profileVC,myWork]
        
    }
    
    private func buildConfig(_ vc: UIViewController, title: String) {
        vc.tabBarItem.title = title
    }
}
