//
//  ColorCollectionCell.swift
//  jogoDoBicho
//
//  Created by apple on 19.03.2024.
//

import Foundation
import UIKit

class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ColorCell"
    
    let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(colorView)
        colorView.frame = contentView.bounds
    }
    
    func configure(with color: UIColor) {
        colorView.backgroundColor = color
    }
}
