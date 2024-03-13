//
//  ZooVC.swift


import Foundation
import UIKit
import SnapKit

class LeadVC: UIViewController {
    
    
    var contentView: LeadView {
        view as? LeadView ?? LeadView()
    }
    
    override func loadView() {
        view = LeadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
