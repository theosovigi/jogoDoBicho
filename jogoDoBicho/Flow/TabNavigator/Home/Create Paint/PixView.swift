//
//  PixView.swift
//  jogoDoBicho
//
//  Created by apple on 19.03.2024.
//

import Foundation
import UIKit
import SnapKit

class PixView: UIView {

//    var colorSelectionHandler: ((UIColor) -> Void)?

    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgAfrica
        return imageView
    }()

    private(set) lazy var fillView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        return view
    }()

    private(set) lazy var timerContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .customBlue
        view.layer.borderColor = UIColor.customYellow.cgColor
        view.layer.borderWidth = 2
        return view
    }()

    private lazy var timeImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timeImg
        return imageView
    }()

    private(set) var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 16)
        label.textColor = .white
        return label
    }()

    private(set) var closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(.closeBtn, for: .normal)
        return button
    }()


    private(set) lazy var imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private(set) lazy var zoomBtn: UIButton = {
        let button = UIButton()
        button.setImage(.zoomBtn, for: .normal)
        button.setImage(.tappedZoom, for: .highlighted)
        return button
    }()

    private(set) lazy var eraserBtn: UIButton = {
        let button = UIButton()
        button.setImage(.eraserBtn, for: .normal)
        button.setImage(.tappedEraser, for: .highlighted)
        return button
    }()

    private(set) lazy var visionBtn: UIButton = {
        let button = UIButton()
        button.setImage(.visionBtn, for: .normal)
        button.setImage(.tappedVision, for: .highlighted)
        return button
    }()

    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .customFont(font: .baloo, style: .regular, size: 28)
        label.textColor = .white
        return label
    }()

    private(set) lazy var fillColorsView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()

    private(set) lazy var brushImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .brushImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) var colorCollectionView: ColorCollectionView = {
        let collectionView = ColorCollectionView()
        return collectionView
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
        [bgImage,fillView,closeBtn,timerContainer,imageContainerView,imageView,imageLabel,zoomBtn,eraserBtn,visionBtn,fillColorsView] .forEach(addSubview(_:))
        timerContainer.addSubview(timeImg)
        timerContainer.addSubview(timeLabel)
        imageContainerView.addSubview(imageView)
        imageContainerView.addSubview(imageLabel)
        fillColorsView.addSubview(brushImg)
        fillColorsView.addSubview(colorCollectionView)

    }

    private func setupConstraints() {
        bgImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        fillView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        timerContainer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(4)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }

        timeImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }

        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeImg.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }

        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(48)
        }

        imageContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(420)
            make.left.right.equalToSuperview().inset(16)
        }

        imageLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(imageLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-24)
        }

        eraserBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imageContainerView.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }

        visionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imageContainerView.snp.bottom).offset(60)
            make.right.equalTo(eraserBtn.snp.left).offset(-24)
        }

        zoomBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imageContainerView.snp.bottom).offset(60)
            make.left.equalTo(eraserBtn.snp.right).offset(24)
        }

        fillColorsView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-80)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }

        brushImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(20)
        }

        colorCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(20)
            make.left.equalTo(brushImg.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
}
