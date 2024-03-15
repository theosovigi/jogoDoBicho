//
//  Image2View.swift
//  jogoDoBicho
//
//  Created by apple on 13.03.2024.
//

import Foundation
import Foundation
import UIKit

class CanadaView: UIView {
    
    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgCanada
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
