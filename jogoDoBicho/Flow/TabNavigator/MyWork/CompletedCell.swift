//
//  CompletedCell.swift


import Foundation
import UIKit
import SnapKit

class CompletedCell: UICollectionViewCell {
    
    var continueButtonAction: (() -> Void)?

    
   private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customOrange
        label.textAlignment = .center
        label.font = .customFont(font: .baloo, style: .regular, size: 16)
        return label
    }()

    private(set) var progressLabel: UILabel = {
         let label = UILabel()
         label.textColor = .white
         label.text = "3%"
         label.textAlignment = .center
         label.font = .customFont(font: .baloo, style: .regular, size: 20)
         return label
     }()

    
    private(set) lazy var imageAnimal: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    private(set) lazy var repaintBtn: UIButton = {
        let button = UIButton()
        button.setImage(.repaintBtn, for: .normal)
        return button
    }()
    
    private lazy var imageArt: PaintView = {
        let ia = PaintView()
        ia.backgroundColor = .clear
        ia.contentMode = .scaleAspectFit
        return ia
    }()
    
    override func layoutSubviews() {
         super.layoutSubviews()
         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
             let converter = PixelArtConverter()
             let image = self.imageAnimal.image!
             let convertedImage = converter.convertToPixelArt(image: image)
             self.imageArt.setup(image: convertedImage!)
         }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .black.withAlphaComponent(0.6)
        self.layer.borderColor = UIColor.customOrange.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 8
        addSubview(progressLabel)
//        addSubview(imageAnimal)
        addSubview(repaintBtn)
        addSubview(imageArt)
        repaintBtn.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc private func continueButtonTapped() {
        continueButtonAction?()
    }


    private func setupConstraints() {
        progressLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
        }
        
        imageArt.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        repaintBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func configureCompleted(with matrix: Matrix) {
        let progressScore = matrix.totalCountPix - matrix.coloredCountPix
        imageAnimal.image = UIImage(named: "\(matrix.name.lowercased())PixColor")
        progressLabel.text = "\(progressScore)"
        imageArt.namePic = matrix.name

    }

}
