//
//  SearchViewController.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import UIKit
import MapKit

final class SearchViewController: UIViewController {

    private let tableView = UITableView()
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    private let searchBar = UISearchBar()

    private var searchViewModel: SearchViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
        setupSearchCompleter()
    }

    func configure(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }

}

private extension SearchViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .purple

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }

    func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.region = MKCoordinateRegion(.world)
    }

    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.placeholder = "Search for place"

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.leading.equalToSuperview()
        }
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .purple
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemPurple]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Search"
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)

        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] (response, error) in
            guard let location = response?.mapItems[0].placemark.location, let self = self else {
                return
            }
            let name = response?.mapItems[0].placemark.name

            self.searchViewModel?.onLocationTapped?(location, name)
        }
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}
