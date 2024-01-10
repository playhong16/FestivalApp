//
//  SearchViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let dataManager = DataManager.shared
    
    var isFiltered: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarhasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarhasText
    }
    
    var filterdFestivals: [Festival] = []
    
    // MARK: - Components

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.dataSource = self
        tv.delegate = self
        tv.register(FestivalCell.self, forCellReuseIdentifier: FestivalCell.identifier)
        return tv
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemBlue
        indicator.center = view.center
        indicator.style = .large
        return indicator
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchControl()
        addSubviews()
        setLayout()
        setupDatas()
    }
    
    // MARK: - Embed
    
    private func embedSearchControl() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "축제 이름을 입력해주세요."
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }

    
    // MARK: - Layout
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(indicator)
    }
    
    func setLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Data
    
    func setupDatas() {
        indicator.startAnimating()
        dataManager.setupDatasFromAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
}

// MARK: - Extension

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        print("search: \(keyword)")
        filterdFestivals = dataManager.festivalList.filter { $0.title.contains(keyword) }
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Button Cliked \(searchBar.text)")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return self.filterdFestivals.count
        }
        
        return dataManager.festivalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FestivalCell.identifier) as? FestivalCell else {
            return UITableViewCell()
        }
        
        if isFiltered {
            let festivals = self.filterdFestivals
            cell.setupData(festivals[indexPath.row])
            return cell
        }
        
        let festivalList = dataManager.festivalList
        cell.setupData(festivalList[indexPath.row])
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let festival = dataManager.festivalList[indexPath.row]
        dataManager.setupInfomationFromAPI(contentID: festival.contentid) { information in
            detailVC.festival = festival
            detailVC.information = information
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
