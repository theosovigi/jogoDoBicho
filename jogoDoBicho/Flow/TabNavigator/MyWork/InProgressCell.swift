//
//  InProgressCell.swift
//

import Foundation
import UIKit
import SnapKit

class InProgressCell: UICollectionViewCell {
    
    var continueButtonAction: (() -> Void)?

   private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .customFont(font: .baloo, style: .regular, size: 10)
        return label
    }()

    private(set) var progressLabel: UILabel = {
         let label = UILabel()
         label.textColor = .red
         label.text = "3%"
         label.textAlignment = .center
         label.font = .customFont(font: .baloo, style: .regular, size: 10)
         return label
     }()

    private(set) lazy var imageAnimal: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    private(set) lazy var continueBtn: UIButton = {
        let button = UIButton()
        button.setImage(.continueBtn, for: .normal)
        return button
    }()
    
    private(set) lazy var imageArt: PaintView = {
        let ia = PaintView()
        ia.backgroundColor = .clear
        ia.contentMode = .scaleAspectFit
        return ia
    }()
    
//    override func layoutSubviews() {
//         super.layoutSubviews()
//         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//             let converter = PixelArtConverter()
//             let image = self.imageAnimal.image!
//             let convertedImage = converter.convertToPixelArt(image: image)
//             self.imageArt.setup(image: convertedImage!)
//         }
//     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .customGreen
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        addSubview(nameLabel)
        addSubview(progressLabel)
        addSubview(imageArt)
//        addSubview(imageAnimal)
        addSubview(continueBtn)
        continueBtn.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc private func continueButtonTapped() {
        continueButtonAction?()
    }


    private func setupConstraints() {
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(4)
        }

        progressLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-4)
        }
        
        imageArt.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(52)
        }
        
        continueBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
    }
    
//    func configure(with matrix: Matrix) {
//        let totalCountPix = matrix.totalCountPix
//        let coloredCountPix = matrix.coloredCountPix
//        
//        let percentProgress = Int((Double(coloredCountPix) / Double(totalCountPix)) * 100)
////        imageArt.namePic = matrix.name
//        nameLabel.text = matrix.name.uppercased()
//        if let image = UIImage(named: "\(matrix.name.lowercased())PixColor") {
//              imageAnimal.image = image
//          } else {
//              imageAnimal.image =  nil
//          }
//        progressLabel.text = "\(percentProgress)%"
//    }
    func configure(with matrix: Matrix, userImage: UIImage?) {
        DispatchQueue.main.async {
            let converter = PixelArtConverter()

            let totalCountPix = matrix.totalCountPix
            let coloredCountPix = matrix.coloredCountPix
            
            let percentProgress = Int((Double(coloredCountPix) / Double(totalCountPix)) * 100)
            self.imageArt.namePic = matrix.name
            self.nameLabel.text = matrix.name.uppercased()
            if let defaultImage = UIImage(named: "\(matrix.name.lowercased())PixColor") {
                self.imageAnimal.image = defaultImage
                let convertedImage = converter.convertToPixelArt(image: defaultImage)
                self.imageArt.setup(image: convertedImage!)

            } else if let image = userImage { // Затем пытаемся использовать пользовательское изображение
                self.imageAnimal.image = image
                let convertedImage = converter.convertToPixelArt(image: image)
                self.imageArt.setup(image: convertedImage!)

                
            } else {
                self.imageAnimal.image = nil // Нет изображений доступно
            }

        }

    }
}
