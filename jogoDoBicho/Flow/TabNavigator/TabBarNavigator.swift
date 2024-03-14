//
//  TabBarNavigator.swift


import UIKit

class TabBarNavigator: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = .clear
        
        let leadVC = LeadVC()
        buildConfig(leadVC, imageName: "leadBtn", selectedImageName: "tappedLeadBtn")
        
        let myFotoVC = MyFotoVC()
        let myFotoNavigation = UINavigationController(rootViewController: myFotoVC)
        buildConfig(myFotoNavigation, imageName: "importBtn", selectedImageName: "tappedMyFotoBtn")

        let homeVC = HomeVC()
        let homeNavigator = UINavigationController(rootViewController: homeVC)
        buildConfig(homeNavigator, imageName: "homeBtn", selectedImageName: "tappedHomeBtn")

        let profileVC = ProfileVC()
        buildConfig(profileVC, imageName: "profileBtn", selectedImageName: "tappedProfileBtn")

        let myWork = MyWorkVC()
        buildConfig(myWork, imageName: "myArtBtn", selectedImageName: "tappedMyArtBtn")
        
        
        viewControllers = [leadVC,myFotoNavigation,homeNavigator,profileVC,myWork]
        selectedViewController = homeNavigator

    }
    
    private func buildConfig(_ vc: UIViewController, imageName: String, selectedImageName: String) {
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
    }
}
