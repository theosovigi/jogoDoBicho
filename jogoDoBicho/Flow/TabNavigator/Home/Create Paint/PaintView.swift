//
//  PaintView.swift
//  jogoDoBicho


import Foundation
import UIKit
import SnapKit
import RealmSwift


//class Matrix: Object {
//    @Persisted var savedColors: List<Int> // Используем List<Int> для хранения числовых значений цветов
//    @Persisted var name: String
//    @Persisted var totalCountPix: Int = 0
//    @Persisted var coloredCountPix: Int = 0
//    @Persisted var isCompleted: Bool = false
//
//}

class PaintView: UIView {
    
    var namePic = ""
    var progressScore: Int = 0
    var colored: Int = 0
    var totalCountPix: Int = 0
    var tapHandler: ((CGPoint) -> Void)?
    var colorMatrix: [[UIColor]] = []
    var changedCells: [(Int, Int)] = []
    var onTotalPixelsUpdated: ((Int) -> Void)?
    private var pixelArtImage: UIImage!
    var tapCongratilation: (() -> Void)? // Замыкание для обработки нажатия

    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgAfrica
        return imageView
    }()
    
    func setup(image: UIImage) {
        pixelArtImage = image
        restoreMatrix(imageName: namePic)
        print("MOunt -- \(namePic)")
        setupColorMatrix()
        setupStackView()
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        tapHandler?(location)
        setupStackView()
        saveMatrix(total: nil, colored: colored)

    }

    func saveMatrix(total: Int?, colored: Int?) {
        let realm = try! Realm()
        if let existingMatrix = realm.objects(Matrix.self).filter("name == %@", namePic).first {
            // Обновляем существующий объект Matrix
            try! realm.write {
                existingMatrix.savedColors.removeAll() // Очищаем существующие цвета
                let colorsAsInts = colorMatrix.flatMap { $0.map { $0.toInt() } }
                existingMatrix.savedColors.append(objectsIn: colorsAsInts)
                if let total = total {
                    existingMatrix.totalCountPix = total
                }
                if let colored = colored {
                    existingMatrix.coloredCountPix = colored
                }
                // Добавляем проверку и обновление isCompleted
                if existingMatrix.totalCountPix == existingMatrix.coloredCountPix {
                    existingMatrix.isCompleted = true
                    tapCongratilation?()
                } else {
                    existingMatrix.isCompleted = false
                }
                print("isCompleted -- \(existingMatrix.isCompleted)")

            }
        } else {
            // Создаем новый объект Matrix
            let matrix = Matrix()
            matrix.savedColors.append(objectsIn: colorMatrix.flatMap { $0.map { $0.toInt() } })
            matrix.name = namePic
            if let total = total {
                matrix.totalCountPix = total
            }
            if let colored = colored {
                matrix.coloredCountPix = colored
            }
            // Добавляем проверку и установку isCompleted
            if matrix.totalCountPix == matrix.coloredCountPix {
                matrix.isCompleted = true
                tapCongratilation?()
            } else {
                matrix.isCompleted = false
            }
            print("isCompleted -- \(matrix.isCompleted)")
            try! realm.write {
                realm.add(matrix)
            }
        }
    }

    // Восстановление данных
    private func restoreMatrix(imageName: String) {
        // Восстановление Matrix из Realm
        let config = Realm.Configuration(
            schemaVersion: 3, // Предполагаем, что предыдущая версия была 0
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 3 {
                    // Для этой миграции не требуется выполнение кода,
                    // так как добавление новых полей обрабатывается автоматически
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
            if let matrix = realm.objects(Matrix.self).filter("name == %@", imageName).first {
                // Восстановление progressScore
                self.progressScore = matrix.totalCountPix - matrix.coloredCountPix
                self.colored = matrix.coloredCountPix
                self.totalCountPix = matrix.totalCountPix
                // Восстановление сохранённых цветов
                let width = 50 // Задаем ширину вашей матрицы цветов, предположим, что она 50
                let savedColors = matrix.savedColors.map { UIColor(fromInt: $0) } // Конвертируем сохраненные значения обратно в UIColor
                var restoredColorMatrix: [[UIColor]] = []

                // Перестраиваем матрицу цветов из сохраненных данных
                for y in 0..<width { // Допустим, ваша матрица - квадрат 50x50
                    var row: [UIColor] = []
                    for x in 0..<width {
                        let index = y * width + x
                        if index < savedColors.count {
                            row.append(savedColors[index])
                        } else {
                            row.append(.clear) // Используем прозрачный цвет для недостающих данных
                        }
                    }
                    restoredColorMatrix.append(row)
                }
                
                self.colorMatrix = restoredColorMatrix // Обновляем локальную матрицу цветов
            }
    }
    
    private func setupColorMatrix() {
        
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
        var count = 0
        
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
                
                if alpha != 0 {
                    count += 1
                }
            }
            colorMatrix.append(rowColors)
        }
        saveMatrix(total: count, colored: nil)
        progressScore = count
        totalCountPix = count
        print("count-- \(count)")
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

