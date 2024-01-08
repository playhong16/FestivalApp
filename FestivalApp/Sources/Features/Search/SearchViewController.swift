//
//  SearchViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let dataManager = DataManager.shared
    
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
        addSubviews()
        setLayout()
        setupDatas()
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

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.festivalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FestivalCell.identifier) as? FestivalCell else {
            return UITableViewCell()
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
