//
//  Image1VC.swift


import Foundation
import UIKit
import SnapKit

class Image1VC: UIViewController {
    
    
    var contentView: Image1View {
        view as? Image1View ?? Image1View()
    }
    
    override func loadView() {
        view = Image1View()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
