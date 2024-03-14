//
//  Image2VC.swift


import Foundation
import UIKit
import SnapKit

class CanadaVC: UIViewController {
    
    
    var contentView: CanadaView {
        view as? CanadaView ?? CanadaView()
    }
    
    override func loadView() {
        view = CanadaView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
