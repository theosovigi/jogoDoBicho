//
//  CompletedCell.swift


import Foundation
import UIKit
import SnapKit

class CompletedCell: UICollectionViewCell {
    
    var continueButtonAction: (() -> Void)?

    private(set) var nameLabel: UILabel = {
         let label = UILabel()
         label.textColor = .black
         label.textAlignment = .center
         label.font = .customFont(font: .baloo, style: .regular, size: 10)
         return label
     }()

     private(set) var numberLabel: UILabel = {
          let label = UILabel()
          label.textColor = .customRed
          label.textAlignment = .center
          label.font = .customFont(font: .baloo, style: .regular, size: 12)
          return label
      }()
     
     private(set) var labelStackView: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.spacing = 4
         return stackView
     }()

    private(set) lazy var imageAnimal: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

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
//        addSubview(progressLabel)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(numberLabel)
        addSubview(labelStackView)
        addSubview(imageAnimal)
    }

    private func setupConstraints() {
        
        labelStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }

//        progressLabel.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(12)
//            make.left.equalToSuperview().offset(12)
//        }
        
        imageAnimal.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    func configureCompleted(with matrix: Matrix, userImage: UIImage?,cellIndex: Int) {
        let totalCountPix = matrix.totalCountPix
        let coloredCountPix = matrix.coloredCountPix
        
        let percentProgress = Int((Double(coloredCountPix) / Double(totalCountPix)) * 100)
        self.nameLabel.text = "\(matrix.name.uppercased())"
        self.numberLabel.text = "\(cellIndex + 1)"
        if let defaultImage = UIImage(named: "\(matrix.name.lowercased())PixColor") {
            self.imageAnimal.image = defaultImage
            
        } else if let image = userImage { // Затем пытаемся использовать пользовательское изображение
            self.imageAnimal.image = image
        } else {
            self.imageAnimal.image = nil // Нет изображений доступно
        }
    }


}
