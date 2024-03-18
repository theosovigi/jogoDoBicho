//
//  StartView.swift
//  jogoDoBicho

import Foundation
import UIKit
import SnapKit

class StartView: UIView {
    
    
    private lazy var backView: GradientBackgroundView = {
        let view = GradientBackgroundView()
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Wellcome".uppercased()
        label.font = .boldSystemFont(ofSize: 40)
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
        label.text = "Loading...".uppercased()
        label.font = .boldSystemFont(ofSize: 36)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
 
    private(set) lazy var loadView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progress = 0.0
        progressView.progressTintColor = .red
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
        [backView,welcomeLabel,eagleImg,loadLabel,loadView] .forEach(addSubview(_:))
    }
            
    private func setUpConstraints(){
        
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(80)
            make.centerX.equalToSuperview()
        }
        
        eagleImg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(280)
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
