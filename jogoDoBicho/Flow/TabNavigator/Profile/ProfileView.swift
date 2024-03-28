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
        view.backgroundColor = .white.withAlphaComponent(0.4)
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
    
    private(set) lazy var editBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.editBtn, for: .normal)
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
    
    private(set) lazy var infoBtn: UIButton = {
        let button = UIButton()
        button.setImage(.infoBtn, for: .normal)
        return button
    }()

    private lazy var paintImgContiner: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .totalPaintImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var titlePaintLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 12)
        label.text = "Total paintings"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var scorePaintLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 24)
        label.text = "\(uD.scorePaint)"
        label.textAlignment = .center
        label.textColor = .customOrange
        label.numberOfLines = 0
        return label
    }()

    private lazy var bestTimeImgContiner: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bestTimeImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var titleTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 12)
        label.text = "Best Time"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var scoreTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 24)
        label.text = formatTime(minutes: 0, seconds: 0)
        label.textAlignment = .center
        label.textColor = .customOrange
        label.numberOfLines = 0
        return label
    }()

    private lazy var scoreImgContiner: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .totalScoreImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var titleScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 12)
        label.text = "Total points"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var scoreCountLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 24)
        label.text = "\(uD.scoreCoints)"
        label.textAlignment = .center
        label.textColor = .customOrange
        label.numberOfLines = 0
        return label
    }()

    private lazy var planetImgContiner: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .totalPlanetImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var titlePlanetLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 12)
        label.text = "Planet passed"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var scorePlanetLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 24)
        label.text = "0"
        label.textAlignment = .center
        label.textColor = .customOrange
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
    
    private(set) lazy var achievementImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .achievementImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var achievementOneLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 10)
        label.text = "Beginner:\nColor your first picture"
        label.textAlignment = .center
        label.textColor = .customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var achievementImageTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .achievementImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var achievementTwoLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 10)
        label.text = "Quick Start:\nColor picture in the 5 minutes of the game"
        label.textAlignment = .center
        label.textColor = .customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var achievementImageThree: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .achievementImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var achievementThreeLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 10)
        label.text = "Amateur Artist:\nPaint 10 pictures"
        label.textAlignment = .center
        label.textColor = .customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var achievementImageFour: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .achievementImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var achievementFourLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 10)
        label.text = "Brush Master:\nPaint 20 pictures."
        label.textAlignment = .center
        label.textColor = .customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var achievementImageFive: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .achievementImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var achievementFiveLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 10)
        label.text = "Collector:\nBuild a collection of 15 pictures."
        label.textAlignment = .center
        label.textColor = .customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var achievementImageSix: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .achievementImg
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var achievementSixLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .baloo, style: .regular, size: 10)
        label.text = "Explorer:\nDiscover 3 islands"
        label.textAlignment = .center
        label.textColor = .customOrange
        label.adjustsFontSizeToFitWidth = true
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
        [bgImage,cloudOneImg,cloudTwoImg,cloudThreeImg,cloudFourImg,starsConteiner,profileContainer,infoBtn ] .forEach(addSubview(_:))
        starsConteiner.addSubview(starsImg)
        starsConteiner.addSubview(starsScore)
//        profileContainer.addSubview(containerImg)
        profileContainer.addSubview(profileLabel)
        profileContainer.addSubview(chosePhotoBtn)
        profileContainer.addSubview(profileTextField)
        profileTextField.addSubview(editBtn)
        profileContainer.addSubview(analizLabel)
        
        profileContainer.addSubview(paintImgContiner)
        paintImgContiner.addSubview(titlePaintLabel)
        paintImgContiner.addSubview(scorePaintLabel)
        
        profileContainer.addSubview(bestTimeImgContiner)
        bestTimeImgContiner.addSubview(titleTimeLabel)
        bestTimeImgContiner.addSubview(scoreTimeLabel)

        profileContainer.addSubview(planetImgContiner)
        planetImgContiner.addSubview(titlePlanetLabel)
        planetImgContiner.addSubview(scorePlanetLabel)

        profileContainer.addSubview(scoreImgContiner)
        scoreImgContiner.addSubview(titleScoreLabel)
        scoreImgContiner.addSubview(scoreCountLabel)

        profileContainer.addSubview(achievementsLabel)
        profileContainer.addSubview(achievementImage)
        profileContainer.addSubview(achievementImageTwo)
        profileContainer.addSubview(achievementImageThree)
        profileContainer.addSubview(achievementImageFour)
        profileContainer.addSubview(achievementImageFive)
        profileContainer.addSubview(achievementImageSix)
        
        achievementImage.addSubview(achievementOneLabel)
        achievementImageTwo.addSubview(achievementTwoLabel)
        achievementImageThree.addSubview(achievementThreeLabel)
        achievementImageFour.addSubview(achievementFourLabel)
        achievementImageFive.addSubview(achievementFiveLabel)
        achievementImageSix.addSubview(achievementSixLabel)


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

        infoBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().offset(-16)
        }

        profileContainer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(56)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
//        containerImg.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
        profileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }

        chosePhotoBtn.snp.makeConstraints { (make) in
            make.top.equalTo(profileLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(60.autoSize)
        }
        
        profileTextField.snp.makeConstraints { (make) in
            make.left.equalTo(chosePhotoBtn.snp.right).offset(12)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(chosePhotoBtn)
            make.height.equalTo(40.autoSize)
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(24.autoSize)
        }

        analizLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }

        paintImgContiner.snp.makeConstraints { (make) in
            make.top.equalTo(analizLabel.snp.bottom).offset(24.autoSize)
            make.right.equalToSuperview().offset(-24.autoSize)
            
        }
        
        titlePaintLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(48)
        }
        
        scorePaintLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(48)
        }

        bestTimeImgContiner.snp.makeConstraints { (make) in
            make.top.equalTo(analizLabel.snp.bottom).offset(24.autoSize)
            make.left.equalToSuperview().offset(24.autoSize)
        }
        
        titleTimeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(48)
        }

        scoreTimeLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(48)
        }

        scoreImgContiner.snp.makeConstraints { (make) in
            make.top.equalTo(paintImgContiner.snp.bottom).offset(12.autoSize)
            make.right.equalToSuperview().offset(-24.autoSize)
        }
        
        titleScoreLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(48)
        }

        scoreCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(48)
        }

        planetImgContiner.snp.makeConstraints { (make) in
            make.top.equalTo(paintImgContiner.snp.bottom).offset(12.autoSize)
            make.left.equalToSuperview().offset(24.autoSize)
        }

        titlePlanetLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(48)
        }

        scorePlanetLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(48)
        }

        achievementsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(planetImgContiner.snp.bottom).offset(24.autoSize)
            make.centerX.equalToSuperview()
        }
        
        achievementImage.snp.makeConstraints { (make) in
            make.top.equalTo(achievementsLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(90.autoSize)
        }

        achievementOneLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(18.autoSize)
            make.bottom.equalToSuperview().offset(-4.autoSize)
            make.left.right.equalToSuperview().inset(8.autoSize)
        }

        achievementImageTwo.snp.makeConstraints { (make) in
            make.top.equalTo(achievementsLabel.snp.bottom)
            make.left.equalTo(achievementImage.snp.right).offset(14)
            make.size.equalTo(90.autoSize)
        }
        
        achievementTwoLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(18.autoSize)
            make.bottom.equalToSuperview().offset(-4.autoSize)
            make.left.right.equalToSuperview().inset(8.autoSize)
        }

        achievementImageThree.snp.makeConstraints { (make) in
            make.top.equalTo(achievementsLabel.snp.bottom)
            make.right.equalTo(achievementImage.snp.left).offset(-14)
            make.size.equalTo(90.autoSize)
        }
        
        achievementThreeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(18.autoSize)
            make.bottom.equalToSuperview().offset(-4.autoSize)
            make.left.right.equalToSuperview().inset(8.autoSize)
        }

        achievementImageFour.snp.makeConstraints { (make) in
            make.top.equalTo(achievementImage.snp.bottom).offset(12.autoSize)
            make.centerX.equalToSuperview()
            make.size.equalTo(90.autoSize)
        }
        
        achievementFourLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(18.autoSize)
            make.bottom.equalToSuperview().offset(-4.autoSize)
            make.left.right.equalToSuperview().inset(8.autoSize)
        }

        achievementImageFive.snp.makeConstraints { (make) in
            make.top.equalTo(achievementImage.snp.bottom).offset(12.autoSize)
            make.left.equalTo(achievementImageFour.snp.right).offset(14)
            make.size.equalTo(90.autoSize)
        }

        achievementFiveLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(18.autoSize)
            make.bottom.equalToSuperview().offset(-4.autoSize)
            make.left.right.equalToSuperview().inset(8.autoSize)
        }

        achievementImageSix.snp.makeConstraints { (make) in
            make.top.equalTo(achievementImage.snp.bottom).offset(12.autoSize)
            make.right.equalTo(achievementImageFour.snp.left).offset(-14)
            make.size.equalTo(90.autoSize)
        }
        
        achievementSixLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(18.autoSize)
            make.bottom.equalToSuperview().offset(-4.autoSize)
            make.left.right.equalToSuperview().inset(8.autoSize)
        }

    }
    
    func formatTime(minutes: Int, seconds: Int) -> String {
        return String(format: "%d:%02d", minutes, seconds)
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

