//
//  AfricaVC.swift


import Foundation
import UIKit
import SnapKit

enum ImageAfricaName: String {
    case ostrichPix = "Ostrich"
    case crocodilePix = "Crocodile"
    case lionPix = "Lion"
    case monkeyPix = "Monkey"
    case peacockPix = "Peacock"
    case elephantPix = "Elephant"
    case camelPix = "Camel"
    
    var colors: [UIColor] {
        switch self {
        case .ostrichPix:
            return [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8,.c9,.c10]
        case .crocodilePix:
            return [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8,.a9]

        case .lionPix:
            return [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8,.b9]

        case .monkeyPix:
            return [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8,.d9]

        case .peacockPix:
            return [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8,.e9,.e10]
        case .elephantPix:
            return [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8,]

        case .camelPix:
            return [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8]
        }
    }
}


class AfricaVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    var images: [UIImage] = []
    var currentIndex: Int = 0
    var imageNames: [ImageAfricaName] = []

    
    var contentView: AfricaView {
        view as? AfricaView ?? AfricaView()
    }
    
    override func loadView() {
        view = AfricaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.backgroundColor = UIColor.clear
    }
    
    private func tappedButtons() {
        contentView.closeBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        contentView.forwardButton.addTarget(self, action: #selector(nextImage), for: .touchUpInside)
        contentView.backwardButton.addTarget(self, action: #selector(previousImage), for: .touchUpInside)
        contentView.didSelectButton.addTarget(self, action: #selector(paintButtonTapped), for: .touchUpInside)

        images = [.ostrichPix, .crocodilePix, .lionPix, .monkeyPix, .peacockPix,.elephantPix,.camelPix]
        
        imageNames = [.ostrichPix, .crocodilePix, .lionPix, .monkeyPix, .peacockPix,.elephantPix,.camelPix]

        contentView.pageControl.numberOfPages = images.count
        
        contentView.pageControl.currentPage = currentIndex
        
        updateImage()

    }
    
    @objc private func paintButtonTapped() {
        // Передаем выбранное изображение и текст для imageLabel
        let image = images[currentIndex]
        let labelText = imageNames[currentIndex].rawValue
        let colors = imageNames[currentIndex].colors // Извлекаем цвета согласно определению в enum
        let paintVC = PaintVC(image: image, labelText: labelText, colors: colors)
        navigationController?.pushViewController(paintVC, animated: true)
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
       }

    @objc private func nextImage() {
           currentIndex = (currentIndex + 1) % images.count
           updateImage()
       }
       
       @objc private func previousImage() {
           currentIndex = (currentIndex - 1 + images.count) % images.count
           updateImage()
       }
       
       private func updateImage() {
           contentView.imageView.image = images[currentIndex]
           contentView.imageLabel.text = imageNames[currentIndex].rawValue
           contentView.pageControl.currentPage = currentIndex
       }

}
