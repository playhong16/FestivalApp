//
//  SearchViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let dataManager = DataManager.shared
    private var api = FestivalAPI()
    private var nextPageNumber: Int = 1
    private var isPaging: Bool = true
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
        if festivals.isEmpty {
            indicator.startAnimating()
            
            fetchDatasFromAPI { [weak self] in
                self?.indicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func fetchDatasFromAPI(completionHandler: @escaping () -> Void) {
        api.execute { [weak self] result in
            switch result {
            case .success(let responseData):
                let festivals  = responseData.response.body.items.festivals
                self?.nextPageNumber += 1
                self?.festivals.append(contentsOf: festivals)
                completionHandler()
            case .failure(let error):
                if let _ = self?.tableView.tableFooterView {
                    self?.tableView.tableFooterView = nil
                }
                print(error)
            }
        }
    }
    
    private func createIndicatorFooter() -> UIView {
        let height = view.bounds.size.height / 8
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: height))
        let indicator = UIActivityIndicatorView()
        indicator.center = footerView.center
        footerView.addSubview(indicator)
        indicator.startAnimating()
        return indicator
    }
}

// MARK: - Extension + UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        if keyword.isEmpty == false {
            self.filterdFestivals = self.festivals.filter { $0.title.contains(keyword) }
            tableView.reloadData()
        }
    }
}

// MARK: - Extension + UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
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
        let festival = self.festivals[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.setupData(festival)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let trigger = scrollView.contentSize.height - scrollView.bounds.height
        
        if scrollView.contentOffset.y > trigger {
            if isPaging {
                isPaging = false
                api.updatePage(nextPageNumber)
                tableView.tableFooterView = createIndicatorFooter()
                
                fetchDatasFromAPI { [weak self] in
                    self?.isPaging = true
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
