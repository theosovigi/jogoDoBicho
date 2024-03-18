//
//  PlanetView.swift


import SnapKit
import Foundation
import UIKit

class PlanetView: UIView {
    
    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgPlanet
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

    private(set) var closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(.closeBtn, for: .normal)
        return button
    }()

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .customFont(font: .baloo, style: .regular, size: 36)
        let attrString = CustomTextStyle.titleLabelAttrString.attributedString(with: "Farm Planet")
        label.attributedText = attrString
        label.textColor = .customBlue
        return label
    }()
    
    private(set) lazy var imageContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 2
        return view
    }()

    private(set) lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(.rightBtn, for: .normal)
        button.setImage(.rightTapped, for: .highlighted)
        return button
    }()
    
    private(set) lazy var didSelectButton: UIButton = {
        let button = UIButton()
        button.setImage(.paintBtn, for: .normal)
        button.setImage(.tappedPaint, for: .highlighted)
        return button
    }()

    private(set) lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.setImage(.leftBtn, for: .normal)
        button.setImage(.leftTappedBtn, for: .highlighted)
        return button
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .customFont(font: .baloo, style: .regular, size: 36)
        label.textColor = .white
        return label
    }()

    private(set) var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .customBlue
        pageControl.pageIndicatorTintColor = .white
        
        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        [bgImage,closeBtn,starsConteiner,titleLabel,imageContainerView,imageView,imageLabel,forwardButton,didSelectButton,backwardButton,pageControl] .forEach(addSubview(_:))
        starsConteiner.addSubview(starsImg)
        starsConteiner.addSubview(starsScore)
        imageContainerView.addSubview(imageView)
        imageContainerView.addSubview(imageLabel)

    }
    
    private func setupConstraints() {
        bgImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(48)
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
            make.top.equalTo(starsConteiner.snp.bottom).offset(52)
            make.centerX.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(374)
            make.width.equalTo(300)
        }

        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(32)
            make.left.right.equalToSuperview().inset(20)
            make.size.equalTo(260)
        }
        
        imageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }

        didSelectButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-88)
            make.centerX.equalToSuperview()
        }

        backwardButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-80)
            make.right.equalTo(didSelectButton.snp.left).offset(-24)
        }

        forwardButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-80)
            make.left.equalTo(didSelectButton.snp.right).offset(24)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(didSelectButton.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
    }
    
}
