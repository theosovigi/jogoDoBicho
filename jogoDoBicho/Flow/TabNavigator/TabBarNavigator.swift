//
//  TabBarNavigator.swift


import UIKit

class TabBarNavigator: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().tintColor = .yellow
        UITabBar.appearance().backgroundColor = .black
        
        
        let homeVC = CarouselViewController()
        let homeNavigator = UINavigationController(rootViewController: homeVC)
        buildConfig(homeNavigator, title: "Home")

        let leadVC = LeadVC()
        buildConfig(leadVC, title: "Leader")
        
        let myFotoVC = MyFotoVC()
        let myFotoNavigation = UINavigationController(rootViewController: myFotoVC)
        buildConfig(myFotoNavigation, title: "My Foto")

        let profileVC = ProfileVC()
        buildConfig(profileVC, title: "Profile")

        let myWork = MyWorkVC()
        buildConfig(myWork, title: "My Work")
        
        
        viewControllers = [leadVC,myFotoNavigation,homeNavigator,profileVC,myWork]
        selectedViewController = homeNavigator

        
    }
    
    private func buildConfig(_ vc: UIViewController, title: String) {
        vc.tabBarItem.title = title
    }
}
