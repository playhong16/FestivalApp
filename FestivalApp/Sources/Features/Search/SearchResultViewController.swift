//
//  SearchResultViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/09.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.dataSource = self
        tv.delegate = self
        tv.register(FestivalCell.self, forCellReuseIdentifier: FestivalCell.identifier)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FestivalCell.identifier) as? FestivalCell else { return UITableViewCell() }
        
        return cell
    }
}

extension SearchResultViewController: UITableViewDelegate {
    
}
