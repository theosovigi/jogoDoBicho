//
//  Image2VC.swift


import Foundation
import UIKit
import SnapKit

class Image2VC: UIViewController {
    
    
    var contentView: Image2View {
        view as? Image2View ?? Image2View()
    }
    
    override func loadView() {
        view = Image2View()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
