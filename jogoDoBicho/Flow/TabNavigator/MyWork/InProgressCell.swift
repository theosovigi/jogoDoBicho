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

    private(set) var progressLabel: UILabel = {
         let label = UILabel()
         label.textColor = .red
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
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(numberLabel)
        addSubview(labelStackView)
        addSubview(imageAnimal)
//        addSubview(progressLabel)
    }

    private func setupConstraints() {
        
        labelStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }

//        progressLabel.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(12)
//            make.right.equalToSuperview().offset(-4)
//        }
        
        imageAnimal.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(12)
            make.size.equalTo(52)
        }
    }
    func configure(with matrix: Matrix, userImage: UIImage?,cellIndex: Int) {
        
        let totalCountPix = matrix.totalCountPix
        let coloredCountPix = matrix.coloredCountPix
        
        let percentProgress = Int((Double(coloredCountPix) / Double(totalCountPix)) * 100)
        self.nameLabel.text = "\(matrix.name.uppercased())"
        if !isNameInEnums(name: self.nameLabel.text ?? "") {
                self.nameLabel.text = "Custom"
            }
        
        self.numberLabel.text = "\(cellIndex + 1)"
        if let defaultImage = UIImage(named: "\(matrix.name.lowercased())PixColor") {
            self.imageAnimal.image = defaultImage
            
        } else if let image = userImage {
            self.imageAnimal.image = image
        } else {
            self.imageAnimal.image = nil
        }
    }
    
private func isNameInEnums(name: String) -> Bool {
        let allNames = ImageAfricaName.allCases.map { $0.rawValue.uppercased() } +
                       ImagePlanetName.allCases.map { $0.rawValue.uppercased() } +
                       ImageCanadaName.allCases.map { $0.rawValue.uppercased() }
        
        return allNames.contains(name.uppercased())
    }
}
