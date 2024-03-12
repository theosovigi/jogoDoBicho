import UIKit
import SnapKit

class HomeView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    let images: [UIImage] = [UIImage(named: "egypt16")!, UIImage(named: "egypt17")!, UIImage(named: "egypt16")!]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupInfiniteScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .green
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupInfiniteScroll() {
        let totalCount = images.count
        let startIndex = totalCount * 1000  // Arbitrary large number to simulate infinite scrolling
        
        collectionView.scrollToItem(at: IndexPath(item: startIndex, section: 0), at: .left, animated: false)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count * 10000  // Arbitrary large number to simulate infinite scrolling
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
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    // MARK: - UICollectionViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let totalCount = images.count * 10000  // Arbitrary large number to simulate infinite scrolling
        let currentIndex = scrollView.contentOffset.x / scrollView.bounds.width
        
        if currentIndex <= 0 {
            // Scrolled to the beginning, move to the end to create infinite scroll
            let newIndex = totalCount - 2
            collectionView.scrollToItem(at: IndexPath(item: newIndex, section: 0), at: .left, animated: false)
        } else if currentIndex >= CGFloat(totalCount - 1) {
            // Scrolled to the end, move to the beginning to create infinite scroll
            let newIndex = 1
            collectionView.scrollToItem(at: IndexPath(item: newIndex, section: 0), at: .left, animated: false)
        }
    }
}
