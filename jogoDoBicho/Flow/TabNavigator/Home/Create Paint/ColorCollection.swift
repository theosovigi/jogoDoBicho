//
//  ColorCollection.swift
//  jogoDoBicho
//
//  Created by apple on 18.03.2024.
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

class ColorCollectionView: UICollectionView {
    private let colors: [UIColor] = [.red, .blue, .green, .yellow, .customBlue,.customYellow,.customOrange,.red,.blue,.green,.yellow,.customBlue,.customYellow,.customOrange,.purple] // Your array of colors
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 50, height: 50)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .clear
        register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as! ColorCell
        cell.configure(with: colors[indexPath.item])
        return cell
    }
}

extension ColorCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle color selection
        let selectedColor = colors[indexPath.item]
        print("Selected color: \(selectedColor)")
    }
}
