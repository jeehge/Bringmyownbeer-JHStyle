//
//  ListViewController.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit

/**
 맥주 목록 화면
 */
final class ListViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel: BeerListViewModel? = nil
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        setup()
    }
    
    // MARK: - Config
    
    private func configTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.register(BeerListCell.self,
                               forCellReuseIdentifier: BeerListCell.identifier)
        
        configConstraint()
    }
    
    private func configConstraint() {
        view.addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func setup() {
//        NetworkManager.request(api: .beer, parameters: nil) { [weak self] (result: Result <[Beer], APIError>) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let result):
//                self.viewModel = BeerListViewModel(beerList: result)
//
//                DispatchQueue.main.async {
//                    self.listTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        BeerService().getBeerList(api: .beer) { (result: Result<[Beer], APIError>) in
            switch result {
            case .success(let result):
                self.viewModel = BeerListViewModel(beerList: result)
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.identifier, for: indexPath) as? BeerListCell else { return UITableViewCell() }
        
        let beer = viewModel?.beerAtIndex(indexPath.row)
        cell.setBeerListCell(beer)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController.viewController(from: .main)
        detailVC.modalTransitionStyle = .flipHorizontal
        detailVC.info = viewModel?.beerAtIndex(indexPath.row)
        push(detailVC)
    }
}
