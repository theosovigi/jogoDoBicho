//
//  MyWorkView.swift

import Foundation
import UIKit
import SnapKit

class MyWorkView: UIView {
    
    
    private lazy var bgImage: GradientBackgroundView = {
        let view = GradientBackgroundView()
        return view
    }()
    
    private lazy var cloudOneImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .one
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var cloudTwoImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .two
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var cloudThreeImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .three
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var cloudFourImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .four
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var starsConteiner: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private lazy var starsImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starsImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var starsScore: UILabel = {
        let label = UILabel()
        label.text = "\(UD.shared.scoreCoints)"
        label.font = .customFont(font: .baloo, style: .regular, size: 20)
        label.textColor = .orange
        return label
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 36)
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "My Arts")
        label.attributedText = attrString
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var inProgressBtn: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.customFont(font: .baloo, style: .regular, size: 20),
            .foregroundColor: UIColor.customBlue]
        let attributedTitle = NSAttributedString(string: "In progress", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.backgroundColor = .clear
        return button
    }()

    private(set) lazy var completedBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Completed", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .customFont(font: .baloo, style: .regular, size: 20)
        button.backgroundColor = .clear
        return button
    }()

    lazy var inProgressCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Вертикальная прокрутка
        layout.minimumLineSpacing = 10 // Расстояние между строками
        layout.minimumInteritemSpacing = 10 // Расстояние между элементами в строке
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [bgImage,cloudOneImg,cloudTwoImg,cloudThreeImg,cloudFourImg,starsConteiner,titleLabel,inProgressBtn,completedBtn,inProgressCollection] .forEach(addSubview(_:))
        starsConteiner.addSubview(starsImg)
        starsConteiner.addSubview(starsScore)
    }
    
    private func setUpConstraints(){
        
        bgImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        cloudOneImg.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(68)
            make.left.equalToSuperview().offset(36)
            make.height.equalTo(26)
            make.width.equalTo(75)
        }
        
        cloudTwoImg.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(56)
            make.right.equalToSuperview().offset(46)
            make.height.equalTo(40)
            make.width.equalTo(188)
        }

        cloudThreeImg.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(188)
            make.left.equalToSuperview().offset(-41)
            make.height.equalTo(46)
            make.width.equalTo(147)
        }
        
        cloudFourImg.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(229)
            make.right.equalToSuperview().offset(50)
            make.height.equalTo(46)
            make.width.equalTo(173)
        }

        starsConteiner.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }

        starsImg.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }

        starsScore.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(starsConteiner.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        inProgressBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(52)
        }
        
        completedBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-52)
        }
        
        inProgressCollection.snp.makeConstraints { make in
            make.top.equalTo(completedBtn.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }

}

