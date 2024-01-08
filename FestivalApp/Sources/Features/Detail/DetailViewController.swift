//
//  DetailViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var festival: Festival?
    var information: Information?
    
    // MARK: - Components
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBlue
        tv.dataSource = self
        tv.delegate = self
        tv.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
        tv.tableHeaderView = headerView
        return tv
    }()
    
    lazy var headerView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3),
            collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        return cv
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayout()
    }
    
    // MARK: - Layout
    
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

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier) as? ContentCell else {
            return UITableViewCell()
        }
        
        guard let festival = self.festival, let information = self.information else { return UITableViewCell() }
        
        cell.mainView.setupData(festival, information: information)
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    // NOTE: InfomationView 의 높이를 계산해서 Cell의 높이를 줄 수는 없을까?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 1.5
    }
}
