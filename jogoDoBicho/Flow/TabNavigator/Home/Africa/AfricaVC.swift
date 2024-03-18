//
//  AfricaVC.swift


import Foundation
import UIKit
import SnapKit

class AfricaVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum ImageAfricaName: String {
        case ostrichPix = "Ostrich"
        case crocodilePix = "Crocodile"
        case lionPix = "Lion"
        case monkeyPix = "Monkey"
        case peacockPix = "Peacock"
        case elephantPix = "Elephant"
        case camelPix = "Camel"
    }

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
        let paintVC = PaintVC(image: image, labelText: labelText)
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
