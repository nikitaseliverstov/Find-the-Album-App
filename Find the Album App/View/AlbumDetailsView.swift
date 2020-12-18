import UIKit

final class AlbumDetailsView: UIView {

    // MARK: - Properties
    private let downloadAlbumCovers = AlbumCoversDownloader()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset.left = 15
        tableView.separatorInset.right = 15
        tableView.allowsSelection = false
        tableView.rowHeight = 84
        tableView.register(AlbumInfoViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(color: .customDarkGrey(),
                                                backgroundColor: .mainWhite())
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return indicator
    }()

    private let albumCover: UIImageView = {
        let imageView = UIImageView(contentMode: .scaleAspectFill,
                                    clipsToBounds: true,
                                    cornerRadius: 20)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let albumTitle: UILabel = {
        let textLabel = UILabel(text: "Loading",
                                font: UIFont.boldSystemFont(ofSize: 20),
                                textColor: .customDarkGrey(),
                                textAlignment: .left)
        textLabel.numberOfLines = 2
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private let artistTitle: UILabel = {
        let textLabel = UILabel(text: "Loading",
                                font: UIFont.systemFont(ofSize: 17),
                                textColor: .additionalInformationText(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private let primaryGenreTitle: UILabel = {
        let textLabel = UILabel(text: "Loading",
                                font: UIFont.systemFont(ofSize: 17),
                                textColor: .additionalInformationText(),
                                textAlignment: .left)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private let songTitle: UILabel = {
        let textLabel = UILabel(text: "Songs",
                                font: UIFont.boldSystemFont(ofSize: 20),
                                textColor: .customDarkGrey(),
                                textAlignment: .center)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .mainWhite()
        startActivityIndicatorWhenLoadingInfoInDetailScreen()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func configureInfoAlbum(albumCover: URL,
                            primaryGenreTitle: String,
                            albumName: String,
                            artistName: String) {
        self.albumCover.image = nil
        artistTitle.text = artistName
        albumTitle.text = albumName
        self.primaryGenreTitle.text = primaryGenreTitle

        downloadAlbumCovers.getCoverData(fromURL: albumCover) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.albumCover.image = UIImage(data: imageData)
                self?.stopActivityIndicatorWhenLoadingInfoInDetailScreen()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func startActivityIndicatorWhenLoadingInfoInDetailScreen () {
        activityIndicator.startAnimating()
    }

    private func stopActivityIndicatorWhenLoadingInfoInDetailScreen () {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    // MARK: - Setup constraints
    private func setupConstraints() {
        tableView.backgroundColor = .mainWhite()

        let stackLabel = UIStackView(arrangedSubviews: [albumTitle,
                                                        artistTitle,
                                                        primaryGenreTitle],
                                     axis: .vertical,
                                     spacing: 0)
        stackLabel.distribution = .fillEqually
        let songTitleWithTableView = UIStackView(arrangedSubviews: [songTitle,
                                                                    tableView],
                                                 axis: .vertical,
                                                 spacing: 10)
        let albumCoverWithStackLabel = UIStackView(arrangedSubviews: [albumCover,
                                                                      stackLabel],
                                                   axis: .horizontal,
                                                   spacing: 30)

        albumCoverWithStackLabel.translatesAutoresizingMaskIntoConstraints = false
        songTitleWithTableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(albumCoverWithStackLabel)
        addSubview(songTitleWithTableView)
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            albumCover.heightAnchor.constraint(equalToConstant: 145.5),
            albumCover.widthAnchor.constraint(equalToConstant: 145.5)
        ])
        NSLayoutConstraint.activate([
            albumCoverWithStackLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            albumCoverWithStackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            albumCoverWithStackLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            songTitleWithTableView.topAnchor.constraint(equalTo: albumCoverWithStackLabel.bottomAnchor, constant: 40),
            songTitleWithTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            songTitleWithTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            songTitleWithTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
