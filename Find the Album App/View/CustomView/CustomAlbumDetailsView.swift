//
//  CustomAlbumDetailsView.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

class CustomAlbumDetailsView: UIView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset.left = 15
        tableView.separatorInset.right = 15
        tableView.rowHeight = 84
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    fileprivate let albumPoster: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "e7ad6959c1ce035db5fdf45fadfc751d")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    fileprivate let albumTitle: UILabel = {
        let textLabel = UILabel(text: "Text",
                                font: UIFont.boldSystemFont(ofSize: 20),
                                textColor: .textAlbumName(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    fileprivate let artistTitle: UILabel = {
        let textLabel = UILabel(text: "Text",
                                font: UIFont.systemFont(ofSize: 17),
                                textColor: .textOtherInformations(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    fileprivate let primaryGenreTitle: UILabel = {
        let textLabel = UILabel(text: "Text",
                                font: UIFont.systemFont(ofSize: 17),
                                textColor: .textOtherInformations(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    fileprivate let songTitle: UILabel = {
        let textLabel = UILabel(text: "Songs",
                                font: UIFont.boldSystemFont(ofSize: 20),
                                textColor: .textAlbumName(),
                                textAlignment: .center)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .mainWhite()
    }
    
    func setupConstraints() {
        tableView.backgroundColor = .mainWhite()
        
        let stackLabel = UIStackView(arrangedSubviews: [albumTitle, artistTitle, primaryGenreTitle], axis: .vertical, spacing: 0)
        stackLabel.distribution = .fillEqually
        let songTitleWithTableView = UIStackView(arrangedSubviews: [songTitle, tableView], axis: .vertical, spacing: 10)
        let allInformationStackView = UIStackView(arrangedSubviews: [albumPoster, stackLabel], axis: .horizontal, spacing: 30)
        
        allInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        songTitleWithTableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(allInformationStackView)
        addSubview(songTitleWithTableView)
        
        NSLayoutConstraint.activate([
            albumPoster.heightAnchor.constraint(equalToConstant: 145.5),
            albumPoster.widthAnchor.constraint(equalToConstant: 145.5)
        ])
        
        NSLayoutConstraint.activate([
            allInformationStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            allInformationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            allInformationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            songTitleWithTableView.topAnchor.constraint(equalTo: allInformationStackView.bottomAnchor, constant: 40),
            songTitleWithTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            songTitleWithTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            songTitleWithTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
