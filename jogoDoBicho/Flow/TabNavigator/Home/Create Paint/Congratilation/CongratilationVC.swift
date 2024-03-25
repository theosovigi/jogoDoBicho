//
//  CongratilationVC.swift



import Foundation
import UIKit
import SnapKit

class CongratilationVC: UIViewController {

    private var ud = UD.shared
    
    var contentView: CongratilationView {
        view as? CongratilationView ?? CongratilationView()
    }
    
    override func loadView() {
        view = CongratilationView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    

    private func tappedButtons() {
        contentView.closeBtn.addTarget(self, action: #selector(closedTapped), for: .touchUpInside)
        contentView.thanksBtn.addTarget(self, action: #selector(closedTapped), for: .touchUpInside)

    }
    @objc private func closedTapped() {
        navigationController?.popToRootViewController(animated: true)
        ud.scoreCoints += 50
        ud.scorePaint += 1
    }

    
}
