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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
    }
    
    private func configTableView() {
//        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(BeerListCell.self, forCellReuseIdentifier: BeerListCell.identifier)
        
        setConstraint()
        
        // autoHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.identifier, for: indexPath) as? BeerListCell else { return UITableViewCell()}
        return cell
    }
}
