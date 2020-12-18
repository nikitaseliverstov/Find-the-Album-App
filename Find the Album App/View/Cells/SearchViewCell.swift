import UIKit

final class SearchViewCell: UICollectionViewCell {

    // MARK: - Properties
    let downloadAlbumCovers = AlbumCoversDownloader()

    private let albumCover: UIImageView = {
        let imageView = UIImageView(contentMode: .scaleAspectFill,
                                    clipsToBounds: true,
                                    cornerRadius: 20)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let activityIndicatorWhenLoadingAlbumCovers: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(color: .customDarkGrey())
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .customDarkGrey()
        return indicator
    }()

    private let albumTitle: UILabel = {
        let textLabel = UILabel(font: UIFont.systemFont(ofSize: 20),
                                textColor: .customDarkGrey(),
                                textAlignment: .center)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func settingAlbum (with text: String, and image: URL) {
        startActivityIndicatorWhenLoadingAlbumCover()

        albumCover.image = nil
        albumTitle.text = ""
        albumTitle.text = text

        downloadAlbumCovers.getCoverData(fromURL: image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.albumCover.image = UIImage(data: imageData )
                self?.stopActivityIndicatorWhenLoadingAlbumCover()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func startActivityIndicatorWhenLoadingAlbumCover () {
        activityIndicatorWhenLoadingAlbumCovers.startAnimating()
    }

    private func stopActivityIndicatorWhenLoadingAlbumCover () {
        activityIndicatorWhenLoadingAlbumCovers.stopAnimating()
        activityIndicatorWhenLoadingAlbumCovers.isHidden = true
    }

    private func setupViews() {
        contentView.addSubview(albumCover)
        contentView.addSubview(albumTitle)
        contentView.addSubview(activityIndicatorWhenLoadingAlbumCovers)
    }

    // MARK: - Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            albumCover.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumCover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            albumTitle.topAnchor.constraint(equalTo: albumCover.bottomAnchor),
            albumTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            activityIndicatorWhenLoadingAlbumCovers.topAnchor.constraint(equalTo: contentView.topAnchor),
            activityIndicatorWhenLoadingAlbumCovers.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            activityIndicatorWhenLoadingAlbumCovers.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            activityIndicatorWhenLoadingAlbumCovers.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
