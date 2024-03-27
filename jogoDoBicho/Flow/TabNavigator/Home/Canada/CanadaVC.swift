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
        
        var colors: [UIColor] {
            switch self {
            case .tigerPix:
                return [.h1,.h2,.h3,.h4,.h5,.h6,.h7]

            case .bearPix:
                return [.i1,.i2,.i3,.i4,.i5,.i6,.i7,.i8,.i9]

            case .dearPix:
                return [.j1,.j2,.j3,.j4,.j5,.j6,.j7,.j8,.j9]

            case .eaglePix:
                return [.k1,.k2,.k3,.k4,.k5,.k6,.k7,.k8,.k9,.k10,.k11,.k12,.k13,.k14,.k15,.k16,.k17,.k18,.k19,.k20,.k21]

            case .snakePix:
                return [.l1,.l2,.l3,.l4,.l5,.l6,.l7,.l8,.l9,.l10,.l11,.l12,.l13,.l14,.l15]

            case .butterflyPix:
                return [.m1,.m2,.m3,.m4,.m5,.m6,.m7,.m8,.m9,.m10]

            }
        }
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
        contentView.didSelectButton.addTarget(self, action: #selector(paintButtonTapped), for: .touchUpInside)

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

    @objc private func paintButtonTapped() {
        let image = images[currentIndex]
        let labelText = imageNames[currentIndex].rawValue
        let colors = imageNames[currentIndex].colors
        let paintVC = PaintVC(image: image, labelText: labelText, colors: colors)
        navigationController?.pushViewController(paintVC, animated: true)
    }
}
