//
//  SearchViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let dataManager = DataManager.shared
    
    private var nextPageNumber: Int = 1
    private var festivals: [Festival] = []
    private var filterdFestivals: [Festival] = []
    
    var isFiltered: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarhasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarhasText
    }
    
    // MARK: - Components
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.dataSource = self
        tv.delegate = self
        tv.register(FestivalCell.self, forCellReuseIdentifier: FestivalCell.identifier)
        return tv
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .lightGray
        indicator.center = view.center
        indicator.style = .large
        return indicator
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "축제 정보"
        navigationController?.setupBarAppearance()
        embedSearchControl()
        addSubviews()
        setLayout()
        setupDatas()
    }
    
    // MARK: - Embed
    
    private func embedSearchControl() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "축제 이름을 입력해주세요."
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    // MARK: - Layout
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(indicator)
    }
    
    private func setLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Data
    
    private func setupDatas() {
        if self.nextPageNumber == 1 {
            indicator.startAnimating()
        }
        
        dataManager.fetchFestivalsFromAPI(pageNumber: nextPageNumber) { [weak self] pageNumber, festivals in
            self?.nextPageNumber = pageNumber
            self?.festivals = festivals
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
            }
        }
    }
    
    private func updateCell() {
        print("Update PageNumber: \(self.nextPageNumber)페이지 입니다.")
        dataManager.fetchFestivalsFromAPI(pageNumber: nextPageNumber) { [weak self] pageNumber, festivals in
            self?.nextPageNumber = pageNumber
            self?.festivals += festivals
            
            DispatchQueue.main.async {
                if let lastRow = self?.tableView.indexPathsForVisibleRows?.last?.row {
                    print("현재 축제 수: \(self?.festivals.count)개")
                    var indexPaths: [IndexPath] = []
                    for new in 1...festivals.count {
                        indexPaths.append(IndexPath(row: lastRow + new, section: 0))
                    }
                    
                    self?.tableView.beginUpdates()
                    self?.tableView.insertRows(at: indexPaths, with: .none)
                    self?.tableView.endUpdates()
                    print("셀 업데이트 후 마지막 행:\(self?.tableView.indexPathsForVisibleRows)")
                }
            }
        }
    }
}

// MARK: - Extension + UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        if keyword.isEmpty == false {
            filterdFestivals = dataManager.festivalList.filter { $0.title.contains(keyword) }
            tableView.reloadData()
        }
    }
}

// MARK: - Extension + UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Button Cliked \(searchBar.text)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if isFiltered {
            searchBar.text = ""
            tableView.reloadData()
        }
    }
}

// MARK: - Extension + UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return self.filterdFestivals.count
        }
        
        return self.festivals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FestivalCell.identifier) as? FestivalCell else {
            return UITableViewCell()
        }
        
        if isFiltered {
            let filteredFestivals = self.filterdFestivals
            cell.setupData(filteredFestivals[indexPath.row])
            return cell
        }
        
        let festivals = self.festivals
        cell.setupData(festivals[indexPath.row])
        
        return cell
    }
}

// MARK: - Extension + UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = view.bounds.size.height / 6
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let festival = dataManager.festivalList[indexPath.row]
        dataManager.fetchFestivalDetailInfomationFromAPI(contentID: festival.contentid) { information in
            detailVC.festival = festival
            detailVC.information = information
            DispatchQueue.main.async {
                detailVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.nextPageNumber != 1 else { return }
        if (indexPath.row + 1) / 10 + 1 == self.nextPageNumber {
            updateCell()
            return
        }
    }
}
