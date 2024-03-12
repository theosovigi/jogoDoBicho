//
//  MyWorkVC.swift


import Foundation
import UIKit
import SnapKit

class MyWorkVC: UIViewController {
    
    
    var contentView: MyWorkView {
        view as? MyWorkView ?? MyWorkView()
    }
    
    override func loadView() {
        view = MyWorkView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
