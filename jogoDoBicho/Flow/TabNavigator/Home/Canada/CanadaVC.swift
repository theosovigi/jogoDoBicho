//
//  Image2VC.swift


import Foundation
import UIKit
import SnapKit

class CanadaVC: UIViewController {
    
    
    enum ImageCanadaName: String {
        case tigerPix = "Tiger"
        case bearPix = "Bear"
        case dearPix = "Dear"
        case eaglePix = "Eagle"
        case snakePix = "Snake"
        case butterflyPix = "Butterfly"
    }

    var images: [UIImage] = []
    var currentIndex: Int = 0
    var imageNames: [ImageCanadaName] = []

    var contentView: CanadaView {
        view as? CanadaView ?? CanadaView()
    }
    
    override func loadView() {
        view = CanadaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    private func tappedButtons() {
        contentView.closeBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        contentView.forwardButton.addTarget(self, action: #selector(nextImage), for: .touchUpInside)
        contentView.backwardButton.addTarget(self, action: #selector(previousImage), for: .touchUpInside)
        
        images = [.tigerPix, .bearPix, .dearPix, .eaglePix, .snakePix, .butterflyPix]
        imageNames = [.tigerPix, .bearPix, .dearPix, .eaglePix, .snakePix, .butterflyPix]
        
        contentView.pageControl.numberOfPages = images.count
        
        contentView.pageControl.currentPage = currentIndex
        

        updateImage()

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
