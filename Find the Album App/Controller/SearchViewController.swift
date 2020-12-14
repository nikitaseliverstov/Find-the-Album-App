//
//  SearchViewController.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

class SearchViewController: GenericCustomViewController<CustomSearchView> {
    
    let searchController = UISearchController(searchResultsController: nil)
    private var searchDataArray = [AlbumSearchData]()
    private let searchDataDownloader = SearchDataDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.dataSource = self
        configureNavigationController()
        downloadMovieData()
    }
    
    private func configureNavigationController() {
        title = "Album search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
    }
    
    private func downloadMovieData() {
        do{ try searchDataDownloader.downloadSearchData { [weak self] searchData in
            self?.searchDataArray = searchData
            self?.customView.collectionView.reloadData()
            }
        } catch Mistakes.iTunesUrlIsEmpty {
            print("URL is missing")
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            let searchData = searchDataArray[indexPath.row]
            customCell.settingAlbum(with: searchData.collectionName, and: URL(string: searchData.artworkUrl100)!)
            cell = customCell
        }
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
