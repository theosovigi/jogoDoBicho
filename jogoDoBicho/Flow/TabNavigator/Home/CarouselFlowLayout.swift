//
//  CarouselFlowLayout.swift


import UIKit

public enum CarouselFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
    case overlap(visibleOffset: CGFloat)
}

open class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate struct LayoutState {
        var size: CGSize
        var direction: UICollectionView.ScrollDirection
        func isEqual(_ otherState: LayoutState) -> Bool {
            return self.size.equalTo(otherState.size) && self.direction == otherState.direction
        }
    }
    
    @IBInspectable open var sideItemScale: CGFloat = 0.68
    @IBInspectable open var sideItemShift: CGFloat = 0
    
    open var spacingMode = CarouselFlowLayoutSpacingMode.fixed(spacing: 30)
    
    fileprivate var state = LayoutState(size: CGSize.zero, direction: .horizontal)
    
    override open func prepare() {
        super.prepare()
        let currentState = LayoutState(size: self.collectionView!.bounds.size, direction: self.scrollDirection)
        
        if !self.state.isEqual(currentState) {
            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
            collectionView?.setContentOffset(.zero, animated: true)
        }
    }
    
    fileprivate func setupCollectionView() {
        guard let collectionView = self.collectionView else { return }
        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
//    fileprivate func updateLayout() {
//        guard let collectionView = self.collectionView else { return }
//
//        let collectionSize = collectionView.bounds.size
//        let isHorizontal = (self.scrollDirection == .horizontal)
//
//        let yInset = (collectionSize.height - self.itemSize.height) / 2
//        let xInset = (collectionSize.width - self.itemSize.width) / 2
//        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)
//
//        let side = isHorizontal ? self.itemSize.width : self.itemSize.height
//        let scaledItemOffset = (side - side * self.sideItemScale) / 2
//        switch self.spacingMode {
//        case .fixed(let spacing):
//            self.minimumLineSpacing = spacing - scaledItemOffset
//        case .overlap(let visibleOffset):
//            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
//            let inset = isHorizontal ? xInset : yInset
//            self.minimumLineSpacing = inset - fullSizeSideItemOverlap
//        }
//    }
    
    fileprivate func updateLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let collectionSize = collectionView.bounds.size
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        let side = isHorizontal ? self.itemSize.width : self.itemSize.height
        let scaledItemOffset = (side - side * self.sideItemScale) / 2
        switch self.spacingMode {
        case .fixed(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            let inset = isHorizontal ? xInset : yInset
            self.minimumLineSpacing = -fullSizeSideItemOverlap + inset
        }
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }
    
    fileprivate func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let collectionCenter = isHorizontal ? collectionView.frame.size.width / 2 : collectionView.frame.size.height / 2
        let offset = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let normalizedCenter = (isHorizontal ? attributes.center.x : attributes.center.y) - offset

        
        let maxDistance = (isHorizontal ? self.itemSize.width : self.itemSize.height) + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance
        
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        let shift = (1 - ratio) * self.sideItemShift
        
        let height = 180 * scale
        let width = 180 * scale
        attributes.size.height = height
        attributes.size.width = width
        
        if attributes.indexPath.item == 0 {
            attributes.zIndex = 1 // Установите значение zIndex для первой ячейки
        }
        if attributes.indexPath.item == 1 {
            attributes.zIndex = 0 // Установите значение zIndex для первой ячейки
        }
        if attributes.indexPath.item == 2 {
            attributes.zIndex = -1 // Установите значение zIndex для первой ячейки
        }
        if attributes.indexPath.item == 3 {
            attributes.zIndex = -2 // Установите значение zIndex для первой ячейки
        }
        
        if let centerIndexPath = collectionView.centerCellIndexPath {
            print("Индекс ячейки, отображаемой по центру: \(centerIndexPath) \(centerIndexPath.row)")
            
            if attributes.indexPath.item == centerIndexPath.row {
                attributes.zIndex = 1 // Установите значение zIndex для первой ячейки
            } else {
                attributes.zIndex = 0 // Установите значение zIndex для остальных ячеек
            }
        } else {
            print("Нет ячейки, отображаемой по центру")
        }
        
        
        if isHorizontal {
            

            attributes.center.y = attributes.center.y + shift
        } else {
            attributes.center.x = attributes.center.x + shift
        }
    
        return attributes
    }
    
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                           withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView , !collectionView.isPagingEnabled,
              let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let midSide = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
        let proposedContentOffsetCenterOrigin = (isHorizontal ? proposedContentOffset.x : proposedContentOffset.y) + midSide
        
        var targetContentOffset: CGPoint
        if isHorizontal {
            let closest = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        } else {
            let closest = layoutAttributes.sorted { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
        }
        return targetContentOffset
    }
}



extension UICollectionView {
    var centerPoint: CGPoint {
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }
    
//    var centerCellIndexPath: IndexPath? {
//        if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
//            print("centerIndexPath --- \(centerIndexPath)")
//            return centerIndexPath
//        }
//        return nil
//    }
    
    func findCenterIndex(view: UIView, collectionView: UICollectionView) -> Int {
        let center = view.convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: center)
        print(index?.row ?? "index not found")
        return index?.row ?? 0
    }
}

extension UICollectionView {
    var centerCellIndexPath: IndexPath? {
        guard let collectionViewLayout = self.collectionViewLayout as? UICollectionViewFlowLayout
               else {
            return nil
        }
        let visibleIndexPaths = self.indexPathsForVisibleItems
        
        let centerOffset: CGFloat
        if collectionViewLayout.scrollDirection == .horizontal {
            centerOffset = self.contentOffset.x + self.bounds.width / 2
        } else {
            centerOffset = self.contentOffset.y + self.bounds.height / 2
        }
        
        var closestIndexPath: IndexPath?
        var closestDistance: CGFloat = CGFloat.greatestFiniteMagnitude
        
        for indexPath in visibleIndexPaths {
            if let attributes = collectionViewLayout.layoutAttributesForItem(at: indexPath) {
                let distance: CGFloat
                if collectionViewLayout.scrollDirection == .horizontal {
                    distance = abs(attributes.center.x - centerOffset)
                } else {
                    distance = abs(attributes.center.y - centerOffset)
                }
                
                if distance < closestDistance {
                    closestDistance = distance
                    closestIndexPath = indexPath
                }
            }
        }
        
        return closestIndexPath
    }
}

//extension UICollectionView {
//    var centerCellIndexPath: IndexPath? {
//        guard let collectionViewLayout = self.collectionViewLayout as? UICollectionViewFlowLayout,
//              let visibleIndexPaths = self.indexPathsForVisibleItems,
//              !visibleIndexPaths.isEmpty else {
//            return nil
//        }
//
//        let centerOffset: CGFloat
//        if collectionViewLayout.scrollDirection == .horizontal {
//            centerOffset = self.contentOffset.x + self.bounds.width / 2
//        } else {
//            centerOffset = self.contentOffset.y + self.bounds.height / 2
//        }
//
//        var closestIndexPath: IndexPath?
//        var closestDistance: CGFloat = CGFloat.greatestFiniteMagnitude
//
//        for indexPath in visibleIndexPaths {
//            if let attributes = collectionViewLayout.layoutAttributesForItem(at: indexPath) {
//                let distance: CGFloat
//                if collectionViewLayout.scrollDirection == .horizontal {
//                    distance = abs(attributes.center.x - centerOffset)
//                } else {
//                    distance = abs(attributes.center.y - centerOffset)
//                }
//
//                if distance < closestDistance {
//                    closestDistance = distance
//                    closestIndexPath = indexPath
//                }
//            }
//        }
//
//        return closestIndexPath
//    }
//}


