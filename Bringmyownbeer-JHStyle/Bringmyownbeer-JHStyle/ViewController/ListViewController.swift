//
//  ListViewController.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit

final class ListViewController: BaseViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    private var beerList: [Beer] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        getBeerList()
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BeerListCell.self, forCellReuseIdentifier: BeerListCell.identifier)
        
        setConstraint()
    }
    
    private func setConstraint() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func getBeerList() {
        NetworkManager.request(api: .beer, parameters: nil) { [weak self] (result: Result <[Beer], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.beerList = result
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.identifier, for: indexPath) as? BeerListCell else { return UITableViewCell()}
        cell.setBeerListCell(beerList[indexPath.row])
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
