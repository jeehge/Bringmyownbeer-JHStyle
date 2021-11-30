//
//  ListViewController.swift
//  Bringmyownbeer-JHStyle
//
//  Created by JH on 2021/11/24.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    private let viewModel = BeerListViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        viewModel.request()
        
        viewModel.delegate = self
//        bind()
    }
    
//    private func bind() {
//        let input = BeerListViewModel.Input(fetch: Observable.just(()))
//
//        let output = viewModel.transform(input: input)
//
//        output.fetch
//            .bind(to: listTableView.rx.items) { [weak self] (tableView, index, model) in
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.identifier) as? BeerListCell else { return UITableViewCell() }
//                cell.setBeerListCell(model)
//                return cell
//            }.disposed(by: disposeBag)
//    }
    
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
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.identifier, for: indexPath) as? BeerListCell else { return UITableViewCell() }
        cell.setBeerListCell(viewModel.list[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController.viewController(from: .main)
        detailVC.modalTransitionStyle = .flipHorizontal
        detailVC.info = viewModel.list[indexPath.row]
        push(detailVC)
    }
}

extension ListViewController: BeerListViewModelDelegate {
    func requestCompletion() {
        DispatchQueue.main.async { [weak self] in
            self?.listTableView.reloadData()
        }
    }
}
