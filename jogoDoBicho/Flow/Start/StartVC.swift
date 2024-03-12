//
//  StartVC.swift
//  jogoDoBicho


import Foundation
import UIKit
import SnapKit

class StartVC: UIViewController {
    
    
    var contentView: StartView {
        view as? StartView ?? StartView()
    }
    
    override func loadView() {
        view = StartView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animateProgressBar()
    }
    
    func animateProgressBar() {
        UIView.animate(withDuration: 1.5) {
            self.contentView.loadView.setProgress(1.0, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                  self.presentHomeScreen()
    }
}
    
    func presentHomeScreen() {
        let vc = TabBarNavigator()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }


    
}
