//
//  Image3VC.swift


import Foundation
import UIKit
import SnapKit

enum ImagePlanetName: String {
    case donkeyPix = "Donkey"
    case dogPix = "Dog"
    case goatPix = "Goat"
    case sheepPix = "Sheep"
    case rabbitPix = "Rabbit"
    case horsePix = "Horse"
    case roosterPix = "Rooster"
    case catPix = "Cat"
    case pigPix = "Pig"
    case bullPix = "Bull"
    case cowPix = "Cow"
    case turkeyPix = "Turkey"
    
    var colors: [UIColor] {
        switch self {
        case .donkeyPix:
            return [.n1,.n2,.n3,.n4,.n5,.n6,.n7,.n8,.n9,.n10,.n11,.n12,.n13,.n14]

        case .dogPix:
            return [.o1,.o2,.o3,.o4,.o5,.o6,.o7,.o8,.o9,.o10,.o11,.o12,.o13,.o14]

        case .goatPix:
            return [.p1,.p2,.p3,.p4,.p5,.p6,.p7,.p8,.p9,.p10]

        case .sheepPix:
            return [.q1,.q2,.q3,.q4,.q5,.q6,.q7,.q8,.q9,.q10,.q11,.q12,.q13,.q14,.q15]

        case .rabbitPix:
            return [.r1,.r2,.r3,.r4,.r5,.r6,.r7,.r8,.r9]

        case .horsePix:
            return [.s1,.s2,.s3,.s4,.s5,.s6,.s7,.s8,.s9,.s10,.s11,.s12,.s13]

        case .roosterPix:
            return [.t1,.t2,.t3,.t4,.t5,.t6,.t7,.t8,.t9,.t10,.t11,.t12,.t13]

        case .catPix:
            return [.u1,.u2,.u3,.u4,.u5,.u6,.u7,.u8,.u9,.u10,.u11]

        case .pigPix:
            return [.v1,.v2,.v3,.v4,.v5,.v6,.v7,.v8,.v9,.v10,.v11]

        case .bullPix:
            return [.w1,.w2,.w3,.w4,.w5,.w6,.w7,.w8,.w9,.w10]

        case .cowPix:
            return [.x1,.x2,.x3,.x4,.x5,.x6,.x7,.x8,.x9,.x10,.x11,.x12]

        case .turkeyPix:
            return [.y1,.y2,.y3,.y4,.y5,.y6,.y7,.y8,.y9]

        }
    }
}

class PlanetVC: UIViewController {
    
    var images: [UIImage] = []
    var currentIndex: Int = 0
    var imageNames: [ImagePlanetName] = []

    
    var contentView: PlanetView {
        view as? PlanetView ?? PlanetView()
    }
    
    override func loadView() {
        view = PlanetView()
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

        images = [.donkeyPix, .dogPix, .goatPix, .sheepPix, .rabbitPix, .horsePix,.roosterPix,.catPix,.pigPix,.bullPix,.cowPix,.turkeyPix]
        
        imageNames = [.donkeyPix, .dogPix, .goatPix, .sheepPix, .rabbitPix, .horsePix,.roosterPix,.catPix,.pigPix,.bullPix,.cowPix,.turkeyPix]

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
