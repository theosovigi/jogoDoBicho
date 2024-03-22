//
//  PaintVC.swift
//  jogoDoBicho
//
//  Created by apple on 18.03.2024.
//

import Foundation
import SnapKit
import UIKit

class PaintVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var colorSelectionHandler: ((UIColor) -> Void)?
    private var clearColor : UIColor = .clear
    
    private var selectedColor: UIColor = .green // Используйте цвет по умолчанию или любой другой цвет по умолчанию, который вам нужен

    private let imageView: UIImageView
    private let imageLabelText: String?
    private var timer: Timer?
    private var elapsedTimeInSeconds = 0
    
    let imagePicker = UIImagePickerController()
    var pixelArtImage: UIImage?
    
    var contentView: PixView {
        view as? PixView ?? PixView()
    }
    override func loadView() {
        view = PixView()
    }
    
    private lazy var imageArt: PaintView = {
        let ia = PaintView()
        ia.backgroundColor = .white
        ia.contentMode = .scaleAspectFit
        return ia
    }()
    
    init(image: UIImage,labelText: String?) {
        self.imageView = UIImageView(image: image)
        self.imageLabelText = labelText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageArt()
        configureView()
        tappedButtons()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.startTimer()
        }
        setupGestureRecognizer()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let converter = PixelArtConverter()
            let image = self.imageView.image!
            let convertedImage = converter.convertToPixelArt(image: image)
            self.imageArt.setup(image: convertedImage!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        stopTimer()
    }
    
    private func calculateTotalPixels() -> Int {
        let pixelsCount = 50 * 50
        return pixelsCount
    }

    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: imageArt, action: #selector(handleTap(_:)))
        imageArt.addGestureRecognizer(tapGesture)
        imageArt.isUserInteractionEnabled = true

        imageArt.tapHandler = { [weak self] location in
                    self?.handleTap(location)
        }
    }

    
    @objc private func handleTap(_ location: CGPoint) {
        print("Нажали")
        let cellWidth = imageArt.frame.width / 50
        let cellHeight = imageArt.frame.height / 50
        
        let columnIndex = Int(location.x / cellWidth)
        let rowIndex = Int(location.y / cellHeight)
        
        if rowIndex < imageArt.colorMatrix.count && columnIndex < imageArt.colorMatrix[rowIndex].count {
            let currentColor = imageArt.colorMatrix[rowIndex][columnIndex]
            
            // Проверяем, является ли цвет не прозрачным
            if !isTransparentColor(color: currentColor) {
                // Обрабатываем случай, если цвет оттенка серого
                if isGrayColor(color: currentColor) {
                    let previousColor = imageArt.colorMatrix[rowIndex][columnIndex]
                    imageArt.colorMatrix[rowIndex][columnIndex] = selectedColor
                    print("selectedColor -- \(selectedColor)")
                    imageArt.changedCells.append((rowIndex, columnIndex)) // Добавление координат измененной ячейки
                    print("Предыдущий цвет: \(previousColor)")
                    clearColor = previousColor
                    
                    // Увеличиваем счетчик закрашенных пикселей
                    imageArt.colored += 1
                    
                    // Обновляем отображение оставшегося количества только если пиксель не был закрашен ранее
                    imageArt.progressScore = imageArt.totalCountPix - imageArt.colored

                   print("Осталось закрасить пикселей: \(imageArt.progressScore)")
                } else {
                    // Просто закрашиваем выбранным цветом, если цвет не оттенок серого
                    if !isAlreadyPainted(atRow: rowIndex, column: columnIndex) {
                        let previousColor = imageArt.colorMatrix[rowIndex][columnIndex]
                        imageArt.colorMatrix[rowIndex][columnIndex] = selectedColor // Используйте выбранный цвет
                        print("selectedColor -- \(selectedColor)")
                        imageArt.changedCells.append((rowIndex, columnIndex)) // Добавление координат измененной ячейки
                        print("Предыдущий цвет: \(previousColor)")
                        
                        // Увеличиваем счетчик закрашенных пикселей
                        imageArt.colored += 1

                        // Обновляем отображение оставшегося количества только если пиксель не был закрашен ранее
                         imageArt.progressScore = imageArt.totalCountPix - imageArt.colored

                        print("Осталось закрасить пикселей: \(imageArt.progressScore)")
                    } else {
                        print("Пиксель уже закрашен.")
                    }
                }
            } else {
                print("Ошибка: Прозрачная ячейку.")
            }
        } else {
            print("Ошибка: Нажатие находится вне рисунка.")
        }
        imageArt.setupStackView() // Обновление представления после нажатия
    }

    @objc private func eraserButtonTapped() {

    }

    private func isAlreadyPainted(atRow row: Int, column: Int) -> Bool {
           let currentColor = imageArt.colorMatrix[row][column]
           return !isTransparentColor(color: currentColor)
       }
    // Функция для проверки, является ли цвет оттенком серого
    private func isGrayColor(color: UIColor) -> Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return red == green && green == blue // Проверяем, равны ли каналы красного, зеленого и синего
    }


    // Проверка, является ли цвет прозрачным
    private func isTransparentColor(color: UIColor) -> Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return alpha == 0 // Проверка на прозрачный цвет
    }

    private func configureImageArt() {
        contentView.imageContainerView.addSubview(imageArt)
        imageArt.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.imageLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().offset(-24)
        }
    }

    private func configureView() {
        contentView.imageView.image = imageView.image
        contentView.imageLabel.text = imageLabelText
        guard let pic = imageLabelText else { return }
        imageArt.namePic = pic
                contentView.colorCollectionView.colorSelectionHandler = { [weak self] selectedColor in
            self?.handleColorSelection(selectedColor)
        }

    }
    
    private func handleColorSelection(_ color: UIColor) {
           // brushImg в выбранный цвет
        selectedColor = color
        contentView.brushImg.backgroundColor = color
        print("Selected color: \(selectedColor)") // Добавьте это для отладки

       }

    
    private func tappedButtons() {
        contentView.closeBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        contentView.visionBtn.addTarget(self, action: #selector(visionButtonTouchDown), for: .touchDown)
        contentView.visionBtn.addTarget(self, action: #selector(visionButtonTouchUpInside), for: .touchUpInside)
        contentView.eraserBtn.addTarget(self, action: #selector(eraserButtonTapped), for: .touchUpInside)

    }
    

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
    }
    
    @objc private func updateTimer() {
        elapsedTimeInSeconds += 1
        let minutes = elapsedTimeInSeconds / 60
        let seconds = elapsedTimeInSeconds % 60
        
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        contentView.timeLabel.text = timeString
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func visionButtonTouchDown() {
        contentView.imageView.isHidden = false
        imageArt.isHidden = true
    }
    
    @objc private func visionButtonTouchUpInside() {
        contentView.imageView.isHidden = true
        imageArt.isHidden = false
    }
    
    func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // - MARK: - Create PixelArt image
    
    func createPixelArt(from image: UIImage) -> UIImage? {
        let grayscaleImage = convertToGrayscale(image: image)
        let width = view.frame.width * 0.9 / 10
        let size = CGSize(width: width, height: width)
        
        // Resize to 20x20
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        grayscaleImage?.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    // - MARK: - Create white-black image
    func convertToGrayscale(image: UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        let beginImage = CIImage(image: image)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        
        if let output = currentFilter!.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgimg)
        }
        return nil
    }
}

import CoreGraphics

class PixelArtConverter {
    
    func convertToPixelArt(image: UIImage) -> UIImage? {
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))
        
        let grayscaleImage = convertToGrayscale(image: resizedImage)
        
        
        return grayscaleImage
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: targetSize)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        image.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    
    func convertToGrayscale(image: UIImage) -> UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        let beginImage = CIImage(image: image)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        
        if let output = currentFilter!.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgimg)
        }
        return image
    }
}

