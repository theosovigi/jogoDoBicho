//
//  ProfileView.swift


import Foundation
import UIKit

class ProfileView: UIView,UITextFieldDelegate {
    
    private let uD = UD.shared
    
    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
        return imageView
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
        let placeholderText = NSAttributedString(string: "user#\(uD.userID ?? 1)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        textField.attributedPlaceholder = placeholderText
        if let savedUserName = uD.userID {
            textField.placeholder = "user#\(savedUserName)"
        }
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.textColor = .white
        textField.backgroundColor = .red
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center
        textField.delegate = self
        textField.returnKeyType = .done
        textField.resignFirstResponder()
        return textField
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
        [bgImage,chosePhotoBtn,profileTextField ] .forEach(addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        bgImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        

        chosePhotoBtn.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(160)
        }
        
        profileTextField.snp.makeConstraints { (make) in
            make.top.equalTo(chosePhotoBtn.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(48)
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

