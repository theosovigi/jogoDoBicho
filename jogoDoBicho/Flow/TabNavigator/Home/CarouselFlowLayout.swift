
//

import Foundation
import UIKit
import SnapKit

class CarouselViewController: UIViewController {

    private var collectionView: UICollectionView!

    let images: [UIImage] = [UIImage.egypt16, UIImage.egypt17, UIImage.egypt18]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .green
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(200) // Вы можете установить высоту, как вам удобно
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }

    }

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) // Убираем отступы
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
        return layout
    }
}


extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = UIImageView(image: images[indexPath.item])
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(150)
        }
        
        return cell
    }
}

extension CarouselViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.item]
        
        switch selectedImage {
        case UIImage(named: "egypt16"):
            let image1VC = Image1VC()
            navigationController?.pushViewController(image1VC, animated: true)
        case UIImage(named: "egypt17"):
            let image2VC = Image2VC()
            navigationController?.pushViewController(image2VC, animated: true)
        case UIImage(named: "egypt18"):
            let image3VC = Image3VC()
            navigationController?.pushViewController(image3VC, animated: true)
        default:
            break
        }
        
    }
}

