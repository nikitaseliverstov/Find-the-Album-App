import UIKit

final class SearchViewController: GenericClassForViewControllers<SearchView> {

    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)

    private let searchDataDownloader = SearchDataDownloader()
    private let internetConnection = CheckInternetConnection()
    private let urlBuilder = UrlBuilder()

    private let estimatedWidth  = 160.0
    private let cellMarginSize = 16.0

    private weak var timer: Timer?

    private var searchDataArray = [AlbumSearchData]()
    private var initialSearchDataArray = [AlbumSearchData]()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        configureNavigationController()
        downloadAlbumData()
        checkInternetConnection()
    }

    // MARK: - Methods
    private func configureNavigationController() {
        title = "Album search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 13, *) {
            navigationController?.overrideUserInterfaceStyle = .light
        } else {
            searchController.hidesNavigationBarDuringPresentation = false
        }
        navigationItem.largeTitleDisplayMode =  .always
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }

    private func checkInternetConnection() {
        internetConnection.checksTheInternetConnection {
            self.showAlert(with: "Internet connection failure", and: "Please turn on the internet")
        }
    }

    private func downloadAlbumData() {
        searchDataDownloader.downloadSearchData(fromURL: .initialITunesUrl) { [weak self] result in
            switch result {
            case .success(let sortedData):
                let sortedData = sortedData.sorted { $0.collectionName < $1.collectionName }
                self?.searchDataArray = sortedData
                self?.initialSearchDataArray = sortedData
                self?.customView.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchDataArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                               for: indexPath) as? SearchViewCell {
            let searchData = searchDataArray[indexPath.row]
            customView.hidePromptTitle()

            if let albumCover = URL(string: searchData.artworkUrl100) {
                customCell.settingAlbum(with: searchData.collectionName, and: albumCover)
            }
            return customCell
        }
        return .init()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = AlbumDetailsViewController()
        let collectionId = searchDataArray[indexPath.row]
        detailViewController.albumId = collectionId
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        customView.startActivityIndicator()
        let iTunesSearchUrl = urlBuilder.withComponent(search: searchText,
                                                       entity: "album",
                                                       path: "/search",
                                                       key: "term").url?.absoluteString
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            if searchText.isEmpty {
                self?.searchDataArray.removeAll()
                self?.customView.collectionView.reloadData()
                self?.customView.showPromptTitle()
                self?.customView.stopActivityIndicator()
            } else {
                self?.searchDataDownloader
                    .downloadSearchData(fromURL: iTunesSearchUrl ?? "") { [weak self] result in
                        switch result {
                        case .success(let searchData):
                            self?.searchDataArray = searchData
                            self?.customView.collectionView.reloadData()
                            self?.customView.showPromptTitle()
                            self?.customView.stopActivityIndicator()
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
            }
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchDataArray.removeAll()
        searchDataArray = initialSearchDataArray
        customView.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width * 1.2)
    }

    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(self.estimatedWidth)
        let cellCount = floor(CGFloat(customView.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (customView.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
}

private extension String {
    static var initialITunesUrl: String {
        "https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=50"
    }
}
