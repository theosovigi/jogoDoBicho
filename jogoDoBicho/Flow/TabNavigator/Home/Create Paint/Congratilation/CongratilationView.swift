//
//  CongratilationView.swift


import Foundation
import UIKit
import SnapKit

class CongratilationView: UIView {
    
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgCloud
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    private lazy var winLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 40)
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "congratilation".uppercased())
        label.attributedText = attrString
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 40)
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "+50 stars".uppercased())
        label.attributedText = attrString
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var starsImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starsCointsImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    private(set) lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(.closeBtn, for: .normal)
        return button
    }()

    private(set) lazy var thanksBtn: UIButton = {
        let button = UIButton()
        button.setImage(.thanksBtn, for: .normal)
        return button
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
        [backImage,closeBtn,winLabel,scoreLabel,starsImg,thanksBtn] .forEach(addSubview(_:))
    }
            
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(48)
        }
        
        winLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(winLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        
        starsImg.snp.makeConstraints { (make) in
            make.top.equalTo(scoreLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(250)
        }
        
        thanksBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.left.right.equalToSuperview().inset(24)
        }


    }
}
