//
//  HomeVC.swift


import Foundation
import UIKit
import SnapKit

let screenWidth =  UIScreen.main.bounds.size.width
let screeHeight =  UIScreen.main.bounds.size.height

class HomeVC: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let layout = CustomLayout()
    let images: [UIImage] = [UIImage(named: "egypt16")!, UIImage(named: "egypt17")!, UIImage(named: "egypt18")!]
    var itemW : CGFloat {
        return screenWidth * 0.4
    }
    
    var itemH: CGFloat {
        return itemW * 1.45
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupInfiniteScroll()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        layout.currentPage = indexPath.item
        layout.previousOffset = layout.updateOffset(collectionView)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
    }

    private func setupInfiniteScroll() {
        let totalCount = images.count
        
    }

    private func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
            
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50.0
        layout.minimumInteritemSpacing = 50.0
        layout.itemSize.width = itemW
        
    NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: screenWidth)
        ])
    }
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let adjustedIndex = indexPath.item % images.count
        let imageView = UIImageView(image: images[adjustedIndex])
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return cell
    }
    
    
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item ==  layout.currentPage {
            print("didSelectItemAt")
        } else {
            print("NO - didSelectItemAt")
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            layout.currentPage = indexPath.item
            layout.previousOffset = layout.updateOffset(collectionView)
            setupCell()
        }
    }
}


extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemW, height: itemH)
    }
}


// MARK: UIScrollViewDelegate
extension HomeVC {
   
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
    
    private func setupCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        for otherCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: otherCell) {
                
                if indexPath.item != layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
}


