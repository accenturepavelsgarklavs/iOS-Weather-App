//
//  SearchViewController.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import UIKit

class SearchViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: SearchResultsViewController())

    let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }

}

private extension SearchViewController {
    func setupNavigationBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search for place"
        navigationController?.navigationBar.tintColor = .purple
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemPurple]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Search"
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }


}