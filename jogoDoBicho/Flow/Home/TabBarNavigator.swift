//
//  TabBarNavigator.swift


import UIKit

class TabBarNavigator: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().tintColor = .yellow
        UITabBar.appearance().backgroundColor = .purple
        
        
//        let bonusVC = BonusVC()
//        buildConfig(bonusVC, title: "Bonus")
//        
//        
//        let coctailsVC = CoctailsVC()
//        let coctailsNavController = UINavigationController(rootViewController: coctailsVC)
//        buildConfig(coctailsNavController, title: "Cocktails")
//        
//        let cardVC = CardVC()
//        buildConfig(cardVC, title: "Card")
//        
//        let newsVC = NewsVC()
//        let newsNavController = UINavigationController(rootViewController: newsVC)
//        buildConfig(newsNavController, title: "News")
//        
//        let infoVC = InfoVC()
//        buildConfig(infoVC, title: "Info")
//        
        
//        viewControllers = [bonusVC, coctailsNavController, cardVC, newsNavController, infoVC]
        
    }
    
    private func buildConfig(_ vc: UIViewController, title: String) {
        vc.tabBarItem.title = title
    }
}
