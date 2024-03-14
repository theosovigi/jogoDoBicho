//
//  PixelArtView.swift
//  jogoDoBicho
//
//  Created by apple on 14.03.2024.
//

import Foundation
import UIKit

class PixelArtView: UIView {
    
    private var pixelArtImage: UIImage!
    private var colorMatrix: [[UIColor]] = []
    
    func setup(image: UIImage) {
        
        pixelArtImage = image
        setupColorMatrix()
        setupView()
//        setupGestureRecognizer() // - Покраска в красный цвет при нажатии
    }
    // - MARK : - Покраска в красный цвет при нажатии
    private func setupGestureRecognizer() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
           self.addGestureRecognizer(tapGesture)
           self.isUserInteractionEnabled = true
       }
    
    

       @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
           let location = gesture.location(in: self)

           // Определите размер ячейки (предполагается, что у вас 20x20 ячеек)
           let cellWidth = self.frame.width / 20
           let cellHeight = self.frame.height / 20

           // Определите индексы ячейки, в которой был сделан тап
           let columnIndex = Int(location.x / cellWidth)
           let rowIndex = Int(location.y / cellHeight)

           // Обновите цвет ячейки (например, установите ее в красный цвет)
           colorMatrix[rowIndex][columnIndex] = UIColor.red

           // Перерисуйте представление
           setupView()
       }
    
    private func setupColorMatrix() {
        guard let cgImage = pixelArtImage.cgImage else { return }
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        var pixelData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        let context = CGContext(data: &pixelData,
                                width: width,
                                height: height,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        for y in 0..<height {
            var rowColors: [UIColor] = []
            for x in 0..<width {
                let offset = ((width * y) + x) * bytesPerPixel
                let alpha = CGFloat(pixelData[offset + 3]) / 255.0
                let red = CGFloat(pixelData[offset]) / 255.0
                let green = CGFloat(pixelData[offset + 1]) / 255.0
                let blue = CGFloat(pixelData[offset + 2]) / 255.0
                let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
                rowColors.append(color)
            }
            colorMatrix.append(rowColors)
        }
    }
    
    private func setupView() {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 1
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        for y in 0..<20 {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.alignment = .fill
            horizontalStackView.spacing = 1
            
            for x in 0..<20 {
                let squareView = UIView()
                squareView.backgroundColor = colorMatrix[y][x]
                horizontalStackView.addArrangedSubview(squareView)
            }
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        self.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
