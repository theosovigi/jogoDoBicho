//
//  LeadCell.swift


import Foundation
import UIKit
import SnapKit

class LeadCell: UITableViewCell {
    
    static let reuseId = String(describing: LeadCell.self)

    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(font: .baloo, style: .regular, size: 16)
        label.textColor = .customOrange
        return label
    }()

    private(set) lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(font: .baloo, style: .regular, size: 16)
        label.textColor = .customOrange
        return label
    }()
    
    private lazy var profleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .accountImg
        return imageView
    }()

    private lazy var starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starsImg
        return imageView
    }()
    
    private(set) lazy var leadView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.customOrange.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setUpConstraints()
    }
    
        func setupUI() {
            backgroundColor = .clear
            contentView.addSubview(leadView)
            contentView.backgroundColor = .clear
            selectionStyle = .none
            [profleImage,nameLabel,scoreLabel,starImage] .forEach(leadView.addSubview(_:))

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        scoreLabel.text =  nil
    }
    
    private func setUpConstraints(){
        
        leadView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(48)
        }

        profleImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.bottom.equalToSuperview().inset(6)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(profleImage)   
            make.left.equalTo(profleImage.snp.right).offset(8)
        }
        
        starImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
        }

        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(starImage)
            make.right.equalTo(starImage.snp.left).offset(-4)
        }
    }
}
