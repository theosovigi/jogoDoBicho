//
//  MyFotoView.swift


import Foundation
import UIKit

class MyFotoView: UIView {
    
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

    private(set) lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(.closeBtn, for: .normal)
        return button
    }()

    let infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var containerImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .containerImg
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        [bgImage,cloudOneImg,cloudTwoImg,cloudThreeImg,cloudFourImg,starsConteiner,closeBtn,infoContainer] .forEach(addSubview(_:))
        starsConteiner.addSubview(starsImg)
        starsConteiner.addSubview(starsScore)
        infoContainer.addSubview(containerImg)
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

        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(46)
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

        infoContainer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(56)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        containerImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

