//
//  InfoVC.swift
//  jogoDoBicho


import Foundation
import UIKit

class InfoVC: UIViewController {
    
    
    var contentView: InfoView {
        view as? InfoView ?? InfoView()
    }
    
    override func loadView() {
        view = InfoView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        contentView.closeBtn.addTarget(self, action: #selector(tappedClose), for: .touchUpInside)
    }

    @objc func tappedClose() {
        navigationController?.popViewController(animated: true)
    }

}
