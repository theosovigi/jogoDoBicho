//
//  PaintView.swift
//  jogoDoBicho


import Foundation
import UIKit
import SnapKit
import RealmSwift

//class Matrix: Object {
//    @Persisted var savedColorMatrix: [[UIColor]]
//    @Persisted var name: String
//}

var savedColorMatrix: [[UIColor]] = []

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
        restoreMatrix()
        setupColorMatrix()
        setupStackView()
    }
    
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        tapHandler?(location)
        setupStackView() // Обновление представления после нажатия
    }
    
    
     func saveMatrix() {
//         let matrix = Matrix()
//         matrix.savedCo lorMatrix = colorMatrix
        savedColorMatrix = colorMatrix
        
//         let realm = try! Realm()
//         // Persist your data easily with a write transaction
//         try! realm.write {
//             realm.add(matrix)
//         }
    }
    
    
    private func restoreMatrix() {
//        var key = Data(count: 64)
//        _ = key.withUnsafeMutableBytes { bytes in
//            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
//        }
//
//        // Add the encryption key to the config and open the realm
//        let config = Realm.Configuration(encryptionKey: key)
//        let realm = try Realm(configuration: config)
//
//        // Use the Realm as normal
//        let matrix = realm.objects(Matrix.self).filter("name contains 'Fido'").first
//        
//        if !matrix.savedColorMatrix.isEmpty{
//            colorMatrix = matrix.savedColorMatrix
//        }
//        
        if !savedColorMatrix.isEmpty{
            colorMatrix = savedColorMatrix
        }
    }
    
    private func setup ColorMatrix() {
        
        if !colorMatrix.isEmpty {
                return
        }
    
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

extension UIColor {
    func toInt() -> Int {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgba: UInt32 = (UInt32)(red * 255.0) << 24 | (UInt32)(green * 255.0) << 16 | (UInt32)(blue * 255.0) << 8 | (UInt32)(alpha * 255.0)
        return Int(rgba)
    }
    
    convenience init(fromInt value: Int) {
        let red = CGFloat((value >> 24) & 0xFF) / 255.0
        let green = CGFloat((value >> 16) & 0xFF) / 255.0
        let blue = CGFloat((value >> 8) & 0xFF) / 255.0
        let alpha = CGFloat(value & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
