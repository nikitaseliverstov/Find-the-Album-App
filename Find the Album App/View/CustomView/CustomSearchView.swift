//
//  CustomSearchView.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

class CustomSearchView: UIView, UICollectionViewDelegate {
    
    private let estimateWidth  = 160.0
    private let cellMarginSize = 16.0

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 90, height: 120)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    fileprivate let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        collectionView.delegate = self
    }
    
    func setupViews() {
        addSubview(collectionView)
        addSubview(activityIndicator)
    }
    
    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func setupConstraints() {
        collectionView.backgroundColor = .mainWhite()
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomSearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width * 1.2)
    }

    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(frame.size.width / estimatedWidth))

        let margin = CGFloat(cellMarginSize * 2)
        let width = (frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
}
