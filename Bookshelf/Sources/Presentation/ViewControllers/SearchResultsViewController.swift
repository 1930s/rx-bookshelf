//
//  SearchResultsViewController.swift
//  Bookshelf
//
//  Created by Mario on 26/4/18.
//  Copyright © 2018 Mario Negro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultsViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    var searchViewModel: SearchViewModel!
    var flowViewController: BookshelfFlowNavigationController!
}

extension SearchResultsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
}

private extension SearchResultsViewController {
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = nil
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.reuseIdentifier)
    }
}

private extension SearchResultsViewController {
    func bindViewModel() {
        bindTableView()
    }
    
    func bindTableView() {
        searchViewModel.results
            .drive(tableView.rx.items(cellIdentifier: SearchResultTableViewCell.reuseIdentifier)) { (index, book: Book, cell: SearchResultTableViewCell) in
                cell.configure(with: book)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Book.self)
            .subscribe(onNext: { [flowViewController] in
                flowViewController?.showDetailOf(book: $0)
            }).disposed(by: disposeBag)
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchViewModel.query.value = searchController.searchBar.text ?? ""
    }
}