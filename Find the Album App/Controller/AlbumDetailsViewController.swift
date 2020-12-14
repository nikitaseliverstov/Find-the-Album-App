//
//  AlbumDetailsViewController.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

class AlbumDetailsViewController: GenericCustomViewController<CustomAlbumDetailsView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        configureNavigationController()
        // Do any additional setup after loading the view.
    }
    
    private func configureNavigationController() {
        title = "Detail"
    }
    
}



extension AlbumDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Text"
            return cell
    }
}
