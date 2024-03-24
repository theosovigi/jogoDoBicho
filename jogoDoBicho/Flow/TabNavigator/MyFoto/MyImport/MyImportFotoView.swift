//
//  MyImportFotoView.swift

import UIKit
import SnapKit

class MyImportFotoView: UIView {
    
    private var importedImage: UIImage!
    private var colorMatrix: [[UIColor]] = []
    private var changedCells: [(Int, Int)] = [] // Дополнительный массив для хранения измененных ячеек

    func setup(image: UIImage) {
        
        importedImage = image
        print("importedImage -- \(image)")
        setupColorMatrix()
        setupView()
    }


    private func setupColorMatrix() {
        guard let cgImage = importedImage.cgImage else { return }
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
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
