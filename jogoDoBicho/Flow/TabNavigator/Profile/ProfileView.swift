//
//  ProfileView.swift


import Foundation
import UIKit
import SnapKit

class ProfileView: UIView,UITextFieldDelegate {
    
    private let uD = UD.shared
    
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

    let profileContainer: UIView = {
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

    private(set) lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 28)
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "Profile")
        label.attributedText = attrString
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var chosePhotoBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.chosePhoto, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var profileTextField: UITextField = {
        let textField = UITextField()
        let placeholderText = NSAttributedString(string: "user#\(uD.userID ?? 1)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlue.withAlphaComponent(0.5)])
        
        textField.attributedPlaceholder = placeholderText
        if let savedUserName = uD.userID {
            textField.placeholder = "user#\(savedUserName)"
        }
        textField.font = .customFont(font: .baloo, style: .regular, size: 20)
        textField.textColor = .customBlue
        textField.backgroundColor = .white
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.customOrange.cgColor
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center
        textField.delegate = self
        textField.returnKeyType = .done
        textField.resignFirstResponder()
        return textField
    }()
    
    private(set) lazy var analizLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 20)
        label.text = "analytics".uppercased()
        label.textAlignment = .center
        label.textColor = .customBlue
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var achievementsLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 20)
        label.text = "achievements".uppercased()
        label.textAlignment = .center
        label.textColor = .customBlue
        label.numberOfLines = 0
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpConstraints()
        saveName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [bgImage,cloudOneImg,cloudTwoImg,cloudThreeImg,cloudFourImg,starsConteiner,profileContainer ] .forEach(addSubview(_:))
        starsConteiner.addSubview(starsImg)
        starsConteiner.addSubview(starsScore)
        profileContainer.addSubview(containerImg)
        profileContainer.addSubview(profileLabel)
        profileContainer.addSubview(chosePhotoBtn)
        profileContainer.addSubview(profileTextField)
        profileContainer.addSubview(analizLabel)
        profileContainer.addSubview(achievementsLabel)

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

        profileContainer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(56)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        containerImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        profileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }

        chosePhotoBtn.snp.makeConstraints { (make) in
            make.top.equalTo(profileLabel.snp.bottom).offset(52)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(60)
        }
        
        profileTextField.snp.makeConstraints { (make) in
            make.left.equalTo(chosePhotoBtn.snp.right).offset(24)
            make.centerY.equalTo(chosePhotoBtn)
            make.width.equalTo(248)
            make.height.equalTo(40)
        }
        
        analizLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }

        achievementsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(analizLabel.snp.bottom).offset(180)
            make.centerX.equalToSuperview()
        }

    }
    
    private func saveName() {
        if let savedUserName = uD.userName {
            profileTextField.text = savedUserName
        }
    }

    internal func textFieldDidEndEditing(_ textField: UITextField) {
        uD.userName = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

