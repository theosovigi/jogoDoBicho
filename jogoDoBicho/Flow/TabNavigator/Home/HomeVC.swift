
//

import Foundation
import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    let images: [UIImage] = [UIImage.africaImg, UIImage.eathImg, UIImage.canadaImg]
    private var currentCenterIndex: IndexPath?

    var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        tappedButtons()
    }

    private func configureCollection() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }


    private func tappedButtons() {
        contentView.rightBtn.addTarget(self, action: #selector(rightBtnTapped), for: .touchUpInside)
        contentView.leftBtn.addTarget(self, action: #selector(leftBtnTapped), for: .touchUpInside)
        contentView.enterBtn.addTarget(self, action: #selector(enterBtnTapped), for: .touchUpInside)

    }
    
    @objc private func leftBtnTapped() {
        guard let currentIndexPath = contentView.collectionView.indexPathsForVisibleItems.first else {
            return
        }
        
        let previousItem = currentIndexPath.item - 1
        guard previousItem >= 0 else {
            return
        }
        
        let previousIndexPath = IndexPath(item: previousItem, section: currentIndexPath.section)
        contentView.collectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        updateWelcomeLabel(for: previousIndexPath)
    }

    @objc private func rightBtnTapped() {
        guard let currentIndexPath = contentView.collectionView.indexPathsForVisibleItems.first,
              let nextIndexPath = contentView.collectionView.indexPathForItem(at: CGPoint(x: contentView.collectionView.contentOffset.x + contentView.collectionView.bounds.width, y: contentView.collectionView.contentOffset.y)),
              nextIndexPath.item < contentView.collectionView.numberOfItems(inSection: 0) else {
            return
        }
        
        contentView.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        updateWelcomeLabel(for: nextIndexPath)
    }

    private func updateWelcomeLabel(for indexPath: IndexPath) {
        let selectedImage = images[indexPath.item]
        
        switch selectedImage {
        case UIImage(named: "africaImg"):
            let attrString = CustomTextStyle.labelAttrString.attributedString(with: "Welcome\nto Africa Planet")
            contentView.welcomeLabel.attributedText = attrString
            break
        case UIImage(named: "eathImg"):
            let attrString = CustomTextStyle.labelAttrString.attributedString(with: "Welcome\nto Farm Planet")
            contentView.welcomeLabel.attributedText = attrString
        case UIImage(named: "canadaImg"):
            let attrString = CustomTextStyle.labelAttrString.attributedString(with: "Welcome\nto Canada Planet")
            contentView.welcomeLabel.attributedText = attrString
        default:
            break
        }
    }

    @objc private func enterBtnTapped() {
            guard let selectedIndexPath = contentView.collectionView.indexPathsForVisibleItems.first else {
                return
            }
            
            let selectedImage = images[selectedIndexPath.item]
            
            switch selectedImage {
            case UIImage(named: "africaImg"):
                let image1VC = AfricaVC()
                navigationController?.pushViewController(image1VC, animated: true)
            case UIImage(named: "eathImg"):
                let image2VC = PlanetVC()
                navigationController?.pushViewController(image2VC, animated: true)
            case UIImage(named: "canadaImg"):
                let image3VC = CanadaVC()
                navigationController?.pushViewController(image3VC, animated: true)
            default:
                break
            }
        }
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = UIImageView(image: images[indexPath.item])
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.item]
        
        switch selectedImage {
        case UIImage(named: "africaImg"):
            let image1VC = AfricaVC()
            navigationController?.pushViewController(image1VC, animated: true)
        case UIImage(named: "eathImg"):
            let image2VC = PlanetVC()
            navigationController?.pushViewController(image2VC, animated: true)
        case UIImage(named: "canadaImg"):
            let image3VC = CanadaVC()
            navigationController?.pushViewController(image3VC, animated: true)
        default:
            break
        }
    }
}

