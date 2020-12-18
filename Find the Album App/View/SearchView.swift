import UIKit

final class SearchView: UIView {

    // MARK: - Properties
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(color: .customDarkGrey(),
                                                backgroundColor: .mainWhite())
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return indicator
    }()

    private let promptTitle: UILabel = {
        let promptLabel = UILabel(text: "Please enter search term above...",
                                  font: UIFont.boldSystemFont(ofSize: 20),
                                  textColor: .customDarkGrey(),
                                  textAlignment: .center)
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        return promptLabel
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func setupViews() {
        addSubview(collectionView)
        addSubview(promptTitle)
        addSubview(activityIndicator)
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func hidePromptTitle() {
        promptTitle.isHidden = true
    }

    func showPromptTitle() {
        promptTitle.isHidden = false
    }

    // MARK: - Setup constraints
    private func setupConstraints() {
        collectionView.backgroundColor = .mainWhite()

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            promptTitle.topAnchor.constraint(equalTo: topAnchor),
            promptTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            promptTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            promptTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200)
        ])
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
