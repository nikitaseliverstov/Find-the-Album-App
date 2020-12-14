//
//  TableViewCell.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    fileprivate let albumPoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "e7ad6959c1ce035db5fdf45fadfc751d")
        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 20
        return imageView
    }()

    fileprivate let songTitle: UILabel = {
        let textLabel = UILabel(text: "Text",
                                font: UIFont.systemFont(ofSize: 17),
                                textColor: .textAlbumName(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    fileprivate let albumTitle: UILabel = {
        let textLabel = UILabel(text: "Text",
                                font: UIFont.systemFont(ofSize: 13),
                                textColor: .textOtherInformations(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    fileprivate let artistNameTitle: UILabel = {
        let textLabel = UILabel(text: "Text",
                                font: UIFont.systemFont(ofSize: 13),
                                textColor: .textOtherInformations(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    
    func setupViews() {
        contentView.addSubview(albumPoster)
        contentView.addSubview(songTitle)
        contentView.addSubview(albumTitle)
        contentView.addSubview(artistNameTitle)
    }
    
    func setupConstraints() {
        
        backgroundColor = .mainWhite()
        
        NSLayoutConstraint.activate([
            albumPoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            albumPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            albumPoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            albumPoster.heightAnchor.constraint(equalToConstant: 60),
            albumPoster.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            songTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            songTitle.leadingAnchor.constraint(equalTo: albumPoster.trailingAnchor, constant: 11),
            songTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            albumTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 2),
            albumTitle.leadingAnchor.constraint(equalTo: albumPoster.trailingAnchor, constant: 11),
            albumTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            artistNameTitle.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 5),
            artistNameTitle.leadingAnchor.constraint(equalTo: albumPoster.trailingAnchor, constant: 11),
            artistNameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            artistNameTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
