//
//  Image3VC.swift


import Foundation
import UIKit
import SnapKit

class Image3VC: UIViewController {
    
    
    var contentView: Image3View {
        view as? Image3View ?? Image3View()
    }
    
    override func loadView() {
        view = Image3View()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
