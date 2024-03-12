//
//  MyWorkView.swift


import Foundation
import UIKit

class MyWorkView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        backgroundColor = .red
    }
    
    private func setupConstraints() {
        
    }
    
}
