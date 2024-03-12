//
//  ZooVC.swift


import Foundation
import UIKit
import SnapKit

class ZooVC: UIViewController {
    
    
    var contentView: ZooView {
        view as? ZooView ?? ZooView()
    }
    
    override func loadView() {
        view = ZooView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
