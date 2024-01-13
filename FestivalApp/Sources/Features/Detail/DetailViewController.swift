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
    
    var titles: [String] {
        ["행사 이름", "행사 날짜", "행사 소개", "행사 문의"]
    }
    
    var contents: [String?] {
        guard let festival = festival, let information = information else { return [] }
        let startDate = festival.eventStartDate.convertContentDate()
        let endDate = festival.eventEndDate.convertContentDate()
        let date = "\(startDate) ~ \(endDate)"
        return [festival.title, date, information.infotext, festival.tel]
    }
    
    // MARK: - Components
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.dataSource = self
        tv.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
        tv.tableHeaderView = headerView
        return tv
    }()
    
    lazy var headerView: UIImageView = {
        let iv = UIImageView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayout()
        setNavigationController()
        setMainImage(urlString: self.festival?.imageURLString)
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
    
    // MARK: - Configure

    func setNavigationController() {
        self.navigationItem.title = "상세 정보"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    // MARK: - Data

    func setMainImage(urlString: String?) {
        guard let urlString = urlString else { return }
        headerView.setImage(to: urlString)
    }
}

// MARK: - Extension

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier) as? ContentCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let text = contents[indexPath.row]
        let changedText = text?.changeBrTag()
        cell.titleLabel.text = title
        cell.contentTextLabel.text = changedText
        cell.selectionStyle = .none
        return cell
    }
}

