//
//  DetailViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class DetailViewController: UIViewController {
    private let dataManager = DataManager.shared
    private var festival: Festival?
    private var information: Information?
    private var titles: [String] {
        ["행사 이름", "행사 날짜", "행사 소개", "행사 문의"]
    }
    private var api: DetailInformationAPI {
        guard let contentID = festival?.contentid else { return DetailInformationAPI(contentID: "") }
        return DetailInformationAPI(contentID: contentID)
    }
    
    private var contents: [String?] {
        guard let festival = self.festival,
              let information = self.information else { return [] }
        let startDate = festival.eventStartDate.convertContentDate()
        let endDate = festival.eventEndDate.convertContentDate()
        let date = "\(startDate) ~ \(endDate)"
        return [festival.title, date, information.infotext, festival.tel]
    }

    // MARK: - Components

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.dataSource = self
        tv.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
        tv.tableHeaderView = headerView
        return tv
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .lightGray
        indicator.center = view.center
        indicator.style = .large
        return indicator
    }()
    
    private lazy var headerView: UIImageView = {
        let iv = UIImageView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let buttonImageConfig = UIImage.SymbolConfiguration(pointSize: 25)
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart", withConfiguration: buttonImageConfig), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: buttonImageConfig), for: .selected)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let homepageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customSky
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.setTitle("홈페이지", for: .normal)        
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        print(indicator.isAnimating)
        setLayout()
        setNavigationController()
        setSavedFestival()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if information == nil {
            indicator.startAnimating()
            print(indicator.isAnimating)
        }
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        view.addSubview(indicator)
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(heartButton)
        bottomView.addSubview(homepageButton)
    }
    
    private func setLayout() {
        let bottomViewHeight = view.bounds.height / 10
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomViewHeight)
        ])
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: bottomViewHeight)
        ])
        
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 25),
            heartButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
        ])
        
        homepageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homepageButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 25),
            homepageButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
        ])
    }
    
    // MARK: - Configure

    private func setNavigationController() {
        self.navigationItem.title = "상세 정보"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    private func setSavedFestival() {
        let result = dataManager.savedFestivals.contains { $0.contentid == festival?.contentid }
        if result == true {
            heartButton.isSelected.toggle()
            return
        }
    }
    
    // MARK: - Data
    
    func setupData(_ festival: Festival) {
        self.festival = festival
        api.execute { [weak self] result in
            switch result {
            case .success(let responseData):
                let information = responseData.response.body.items.information.first
                self?.information = information
                self?.setMainImage(urlString: festival.imageURLString)
                self?.indicator.stopAnimating()
                self?.tableView.reloadData()
            case .failure(let error):
                print("ERROR: DetailVC - \(error)")
            }
        }
    }
    
    private func setMainImage(urlString: String?) {
        guard let urlString = urlString else { return }
        headerView.setImage(to: urlString)
    }
    
    // MARK: - Action
    
    @objc
    func heartButtonTapped(_ sender: UIButton) {
        guard let festival = self.festival else { return }
        heartButton.isSelected.toggle()
        information?.isSaved.toggle()
        
        if information?.isSaved == true {
            dataManager.saveFestival(festival)
            return
        }
        
        if information?.isSaved == false {
            dataManager.removeFestival(festival)
            return
        }
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

