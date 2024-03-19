//
//  PaintView.swift
//  jogoDoBicho


import Foundation
import UIKit
import SnapKit

class PaintView: UIView {
    
    var tapHandler: ((CGPoint) -> Void)?
    private var pixelArtImage: UIImage!
    var colorMatrix: [[UIColor]] = []
     var changedCells: [(Int, Int)] = [] // Дополнительный массив для хранения измененных ячеек
    
    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgAfrica
        return imageView
    }()
    
    func setup(image: UIImage) {
        pixelArtImage = image
        setupColorMatrix()
        setupStackView()
    }
    
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        tapHandler?(location)
        setupStackView() // Обновление представления после нажатия
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
    
     func setupStackView() {
        // Создаем стековое представление только если оно еще не создано
        if subviews.isEmpty {
            let verticalStackView = UIStackView()
            verticalStackView.axis = .vertical
            verticalStackView.distribution = .fillEqually
            verticalStackView.alignment = .fill
            verticalStackView.spacing = 1
            verticalStackView.translatesAutoresizingMaskIntoConstraints = false
            
            for y in 0..<50 {
                let horizontalStackView = UIStackView()
                horizontalStackView.axis = .horizontal
                horizontalStackView.distribution = .fillEqually
                horizontalStackView.alignment = .fill
                horizontalStackView.spacing = 1
                
                for x in 0..<50 {
                    let squareView = UIView()
                    squareView.backgroundColor = colorMatrix[y][x]
                    horizontalStackView.addArrangedSubview(squareView)
                }
                verticalStackView.addArrangedSubview(horizontalStackView)
            }
            
            self.addSubview(verticalStackView)
            
            verticalStackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            // Обновляем только измененные ячейки
            for (row, column) in changedCells {
                if row < 50 && column < 50 {
                    if let verticalStackView = subviews.first as? UIStackView, // Получаем вертикальное стековое представление
                       let horizontalStackView = verticalStackView.arrangedSubviews[row] as? UIStackView, // Получаем горизонтальное стековое представление
                       let squareView = horizontalStackView.arrangedSubviews[column] as? UIView { // Получаем квадратное представление (ячейку)
                        squareView.backgroundColor = colorMatrix[row][column] // Обновляем цвет ячейки
                    }
                }
            }
        }
    }
    
}
