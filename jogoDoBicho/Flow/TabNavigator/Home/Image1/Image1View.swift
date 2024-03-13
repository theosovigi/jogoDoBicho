//
//  Image1View.swift
//  jogoDoBicho


import Foundation
import UIKit

class Image1View: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        backgroundColor = .darkGray
    }
    
    private func setupConstraints() {
        
    }
    
}
