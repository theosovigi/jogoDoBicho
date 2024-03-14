//
//  Image1View.swift
//  jogoDoBicho


import Foundation
import UIKit
import SnapKit

class AfricaView: UIView {
    
    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgAfrica
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        [bgImage ] .forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        
        bgImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
