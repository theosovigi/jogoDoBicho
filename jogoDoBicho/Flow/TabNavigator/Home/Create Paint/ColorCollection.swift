//
//  ColorCollection.swift

import Foundation
import UIKit


class ColorCollectionView: UICollectionView {
    var colorSelectionHandler: ((UIColor) -> Void)?

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
        colorSelectionHandler?(selectedColor)

    }
}
