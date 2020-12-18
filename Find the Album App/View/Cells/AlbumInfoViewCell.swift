import UIKit

final class AlbumInfoViewCell: UITableViewCell {

    // MARK: - Properties
    let downloadAlbumCovers = AlbumCoversDownloader()

    private let albumCover: UIImageView = {
        let imageView = UIImageView(contentMode: .scaleAspectFill,
                                    clipsToBounds: true,
                                    cornerRadius: 10)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let activityIndicatorWhenLoadingAlbumCover: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(color: .customDarkGrey())
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let songTitle: UILabel = {
        let textLabel = UILabel(font: UIFont.systemFont(ofSize: 17),
                                textColor: .customDarkGrey(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private let albumTitle: UILabel = {
        let textLabel = UILabel(font: UIFont.systemFont(ofSize: 13),
                                textColor: .additionalInformationText(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private let artistNameTitle: UILabel = {
        let textLabel = UILabel(font: UIFont.systemFont(ofSize: 13),
                                textColor: .additionalInformationText(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func configureTableCell(albumCover: URL,
                            nameOfTheSongLabel: String,
                            nameOfTheAlbumLabel: String,
                            artistName: String) {
        startActivityIndicatorWhenLoadingAlbumCover()

        self.albumCover.image = nil
        songTitle.text = nameOfTheSongLabel
        albumTitle.text = nameOfTheAlbumLabel
        artistNameTitle.text = artistName

        downloadAlbumCovers.getCoverData(fromURL: albumCover) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.albumCover.image = UIImage(data: imageData)
                self?.stopActivityIndicatorWhenLoadingAlbumCover()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func startActivityIndicatorWhenLoadingAlbumCover () {
        activityIndicatorWhenLoadingAlbumCover.startAnimating()
    }

    private func stopActivityIndicatorWhenLoadingAlbumCover () {
        activityIndicatorWhenLoadingAlbumCover.stopAnimating()
        activityIndicatorWhenLoadingAlbumCover.isHidden = true
    }

    private func setupViews() {
        contentView.addSubview(albumCover)
        contentView.addSubview(songTitle)
        contentView.addSubview(albumTitle)
        contentView.addSubview(artistNameTitle)
        contentView.addSubview(activityIndicatorWhenLoadingAlbumCover)
    }

    // MARK: - Setup constraints
    private func setupConstraints() {
        backgroundColor = .mainWhite()

        NSLayoutConstraint.activate([
            albumCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            albumCover.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            albumCover.heightAnchor.constraint(equalToConstant: 60),
            albumCover.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            songTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            songTitle.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 11),
            songTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            albumTitle.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 2),
            albumTitle.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 11),
            albumTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            artistNameTitle.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 5),
            artistNameTitle.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 11),
            artistNameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            artistNameTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            activityIndicatorWhenLoadingAlbumCover.topAnchor.constraint(equalTo: albumCover.topAnchor),
            activityIndicatorWhenLoadingAlbumCover.leadingAnchor.constraint(equalTo: albumCover.leadingAnchor),
            activityIndicatorWhenLoadingAlbumCover.trailingAnchor.constraint(equalTo: albumCover.trailingAnchor),
            activityIndicatorWhenLoadingAlbumCover.bottomAnchor.constraint(equalTo: albumCover.bottomAnchor)
        ])
    }
}
