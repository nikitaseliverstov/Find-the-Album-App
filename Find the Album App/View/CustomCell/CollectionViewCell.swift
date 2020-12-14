//
//  CollectionViewCell.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    fileprivate let albumPoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    fileprivate let activityIndicator: UIActivityIndicatorView = {
       
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    fileprivate let albumTitle: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.tintColor = .textAlbumName()
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 20)
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        setupViews()
        setupConstraints()
    }
    
    func settingAlbum (with text: String, and image: URL) {
        
        activityIndicator.startAnimating()
        albumTitle.text = text
        DispatchQueue.global(qos: .utility).async {
            let data = try? Data(contentsOf: image)
            if let data = data {
        DispatchQueue.main.async { [weak self] in
                self?.albumPoster.image = UIImage(data: data)
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
            
            
        }}
        
    }
    
    func setupViews() {
        contentView.addSubview(albumPoster)
        contentView.addSubview(albumTitle)
        contentView.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            albumPoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumPoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            albumTitle.topAnchor.constraint(equalTo: albumPoster.bottomAnchor),
            albumTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
