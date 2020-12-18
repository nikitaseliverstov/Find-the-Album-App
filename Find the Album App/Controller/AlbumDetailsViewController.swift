import UIKit

final class AlbumDetailsViewController: GenericClassForViewControllers<AlbumDetailsView> {

    // MARK: - Properties
    private var albumInfoDataArray = [AlbumData]()
    private let albumDataDownloader = AlbumDataDownloader()
    private let urlBuilder = UrlBuilder()

    var albumId: AlbumSearchData?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        configureNavigationController()
        downloadAlbumDetailsData()
    }

    // MARK: - Methods
    private func configureNavigationController() {
        title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .black
    }

    private func downloadAlbumDetailsData() {
        guard let albumId = albumId else {
            print("AlbumID is empty")
            return
        }
        albumDataDownloader.downloadAlbumData(fromURL: urlBuilder.withComponent(search: String(albumId.collectionId),
                                                                             entity: "song",
                                                                             path: "/lookup",
                                                                             key: "id")
                                                .url?
                                                .absoluteString ?? "") { [weak self] result in
            switch result {
            case .success(let albumData):
                self?.albumInfoDataArray = albumData

                if let albumCoverUrl = URL(string: albumData[0].artworkUrl100) {
                    self?.customView.configureInfoAlbum(albumCover: albumCoverUrl,
                                                        primaryGenreTitle: albumData[0].primaryGenreName,
                                                        albumName: albumData[0].collectionName,
                                                        artistName: albumData[0].artistName)
                }

                self?.albumInfoDataArray.remove(at: 0)
                self?.customView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension AlbumDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumInfoDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                          for: indexPath) as? AlbumInfoViewCell {
            let albumInfoData = albumInfoDataArray[indexPath.row]
            if let albumCover = URL(string: albumInfoData.artworkUrl100) {
                customCell.configureTableCell(albumCover: albumCover,
                                              nameOfTheSongLabel: albumInfoData.trackName ?? "",
                                              nameOfTheAlbumLabel: albumInfoData.collectionName,
                                              artistName: albumInfoData.artistName)
            }
            return customCell
        }
        return .init()
    }
}
