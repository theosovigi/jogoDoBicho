//
//  Image3VC.swift


import Foundation
import UIKit
import SnapKit

class PlanetVC: UIViewController {
    
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
    }

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
        let paintVC = PaintVC(image: image, labelText: labelText)
        navigationController?.pushViewController(paintVC, animated: true)
    }


}
