//
//  SearchViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Components

    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemYellow
        return tv
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayout()
    }
    
    // MARK: - Configure
    
    func addSubviews() {
        view.addSubview(tableView)
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
}
