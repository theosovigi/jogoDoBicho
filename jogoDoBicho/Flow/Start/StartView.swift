//
//  StartView.swift
//  jogoDoBicho

import Foundation
import UIKit
import SnapKit

class StartView: UIView {
    
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgCloud
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 40)
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "\(Settings.appTitle)".uppercased())
        label.attributedText = attrString
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var eagleImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .eagleImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var loadLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 40)
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "Loading...".uppercased())
        label.attributedText = attrString
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
 
    private(set) lazy var loadView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progress = 0.0
        progressView.progressTintColor = .customOrange
        return progressView
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
        [backImage,welcomeLabel,eagleImg,loadLabel,loadView] .forEach(addSubview(_:))
    }
            
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(80)
            make.centerX.equalToSuperview()
        }
        
        eagleImg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }


        loadLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-100)
            make.centerX.equalToSuperview()
        }

        loadView.snp.makeConstraints { (make) in
            make.top.equalTo(loadLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
    }
}
