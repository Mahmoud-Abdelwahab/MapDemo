//
//  BranchCardView.swift
//  MapDemo
//
//  Created by Mahmoud Abdulwahab on 24/06/2023.
//

import UIKit

class BranchCardView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
   
    
    // MARK: - Properties
    var didTapOnCard: ((Int) -> ())?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Methods
    private func commonInit() {
        loadViewFromNib()
        setupUI()
    }

}

// MARK: - Configuration
extension BranchCardView: ReusableCardViewType {

    private func setupUI() {
        setupCollectionView()
 
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BranchCardCell.self, forCellWithReuseIdentifier: BranchCardCell.identifier)

        
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.contentInsetAdjustmentBehavior = .always
//        let paddingArea: CGFloat = 10
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        layout.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        layout.itemSize = CGSize(width: collectionView.frame.width - paddingArea, height: 150)
//        collectionView?.setCollectionViewLayout(layout, animated: true)
    }
   
    func configureCell() {
        
    }
}


// MARK: - CollectionView
extension BranchCardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BranchCardCell.identifier, for: indexPath) as! BranchCardCell

            return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
 
            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.visibleSize)
            let centerPoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            
            if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
                didTapOnCard?(indexPath.row)
                print("✅: New cell appears")
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        didTapOnCard?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemCount = 7
//        let spacing = (CGFloat(itemCount - 1) * 10)
//        let width: CGFloat = (collectionView.bounds.width ) / CGFloat(itemCount)
//
//        let itemHeight = collectionView.bounds.height
        return CGSize(width: 180, height: 130)
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        // Check if a new cell appeared on the screen
//        for indexPath in collectionView.indexPathsForVisibleItems {
//            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
//            let cellRect = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
//            if visibleRect.intersects(cellRect) {
//                // Perform the action when a new cell appears
//                print("✅")
//                didTapOnCard?(indexPath.row)
//                break
//            }
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}


//UICollectionViewDelegate, UICollectionViewDataSource,
//UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        isLoading ? 3 : (dataSource?.count ?? .zero)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: ReusableCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
//        isLoading ? cell.startShimmering() : cell.stopShimmering()
//        if let datasourcse = dataSource {
//            cell.configureCell(viewModel: datasourcse[indexPath.item])
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemCount = dataSource?.count ?? 3
//        let spacing = (CGFloat(itemCount - 1) * 10)
//        let width: CGFloat = (collectionView.bounds.width - spacing) / CGFloat(itemCount)
//        let itemHeight = collectionView.bounds.height
//        return CGSize(width: width, height: itemHeight)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let datasourcse = dataSource {
//            handleSelection?(datasourcse[indexPath.row])
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
