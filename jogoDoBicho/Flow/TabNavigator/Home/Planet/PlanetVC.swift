//
//  Image3VC.swift


import Foundation
import UIKit
import SnapKit

class PlanetVC: UIViewController {
    
    
    var contentView: PlanetView {
        view as? PlanetView ?? PlanetView()
    }
    
    override func loadView() {
        view = PlanetView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
    }

}
