//
//  MyImportVC.swift
//  jogoDoBicho


import Foundation
import UIKit
import SnapKit

class MyImportVC: UIViewController {
    
    var importedImage: UIImage? // Переменная для хранения переданного изображения
    var imageName: String?

    var contentView: MyImportView {
        view as? MyImportView ?? MyImportView()
    }
    
    private lazy var imageArt: MyImportFotoView = {
        let ia = MyImportFotoView()
        ia.backgroundColor = .white
        ia.contentMode = .scaleAspectFit
        return ia
    }()

    override func loadView() {
        view = MyImportView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureImportArt()
        tappedButtons()
        print("Import -- \(importedImage)")
        print("imageName-- \(imageName)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let converter = PixelArtConverter()
            if let image = self.importedImage {
                let converter = PixelArtConverter()
                if let convertedImage = converter.convertToPixelArtColor(image: image) {
                    print("ImportONE -- \(convertedImage)")

                    self.imageArt.setup(image: convertedImage)
                } else {
                    print("Не удалось конвертировать изображение")
                }
            } else {
                print("Не передано изображение")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        // Здесь вы можете использовать importedImage для отображения переданного изображения
        if let image = importedImage {
              // Установим изображение в imageYouView вашего contentView
              contentView.setImage(image)
          } else {
              print("Не передано изображение")
          }
    }
    
    
    private func configureImportArt() {
        contentView.imageYouView.addSubview(imageArt)
        imageArt.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    private func tappedButtons() {
        contentView.closeBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        contentView.visionBtn.addTarget(self, action: #selector(visionOpen), for: .touchUpInside)
        contentView.paintBtn.addTarget(self, action: #selector(goPaint), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func visionOpen() {
        imageArt.isHidden = !imageArt.isHidden
    }

    @objc private func goPaint() {
        if let image = importedImage {
            let paintVC = PaintVC(image: image, labelText: imageName)
            navigationController?.pushViewController(paintVC, animated: true)
        } else {
            // Обработка случая, когда importedImage равен nil
            print("importedImage равен nil")
        }
    }
}
