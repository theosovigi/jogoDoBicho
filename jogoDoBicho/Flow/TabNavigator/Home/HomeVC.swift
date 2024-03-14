
//

import Foundation
import UIKit
import SnapKit

class HomeVC: UIViewController {

//    private var collectionView: UICollectionView!

    let images: [UIImage] = [UIImage.africaImg, UIImage.eathImg, UIImage.canadaImg]

    var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .cyan
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
//        collectionView.backgroundColor = .clear
            contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
//
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//
//        view.addSubview(collectionView)
//        collectionView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.height.equalTo(400)
//            make.width.equalToSuperview()
//        }

    }

//    func createLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // Изменение высоты на .fractionalHeight(1.0)
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) // Убираем отступы
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // Изменение высоты на .fractionalHeight(1.0)
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPaging
//            return section
//        }
//        return layout
//    }

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
            let image2VC = CanadaVC()
            navigationController?.pushViewController(image2VC, animated: true)
        case UIImage(named: "canadaImg"):
            let image3VC = PlanetVC()
            navigationController?.pushViewController(image3VC, animated: true)
        default:
            break
        }
        
    }
}

