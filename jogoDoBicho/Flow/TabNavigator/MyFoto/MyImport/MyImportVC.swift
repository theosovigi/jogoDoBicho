//
//  MyImportVC.swift
//  jogoDoBicho


import Foundation
import UIKit


class MyImportVC: UIViewController {
    
    var importedImage: UIImage? // Переменная для хранения переданного изображения
    
    var contentView: MyImportView {
        view as? MyImportView ?? MyImportView()
    }
    
    override func loadView() {
        view = MyImportView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Здесь вы можете использовать importedImage для отображения переданного изображения
        if let image = importedImage {
            let imageView = UIImageView(image: image)
            // Например, добавим imageView на экран
            view.addSubview(imageView)
            // Установим его размер и позицию, чтобы он занимал всю область экрана
            imageView.frame = view.bounds
            imageView.contentMode = .scaleAspectFit
        } else {
            print("Не передано изображение")
        }
    }
}
