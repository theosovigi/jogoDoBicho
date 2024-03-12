//
//  MyFotoView.swift


import Foundation
import UIKit

class MyFotoView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        backgroundColor = .blue
    }
    
    private func setupConstraints() {
        
    }
    
}
