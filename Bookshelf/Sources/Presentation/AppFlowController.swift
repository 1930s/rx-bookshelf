//
//  AppFlowController.swift
//  Bookshelf
//
//  Created by Mario on 26/4/18.
//  Copyright © 2018 Mario Negro. All rights reserved.
//

import UIKit

protocol AppFlowController {
    func configureInitialViewController()
    func showDetailOf(book: Book)
}

class BookshelfFlowNavigationController: UINavigationController, AppFlowController {
    private var searchResultsViewController: SearchResultsViewController {
        let searchResultsViewController = SearchResultsViewController(style: .plain)
        ServiceLocator.injectDependencies(to: searchResultsViewController)
        searchResultsViewController.flowViewController = self
        return searchResultsViewController
    }
    
    func configureInitialViewController() {
        guard let listViewController = topViewController as? ListViewController else {
            fatalError("Initial UI is not correctly configured, please review Main.storyboard")
        }
        ServiceLocator.injectDependencies(to: listViewController)
        listViewController.searchResultsViewController = searchResultsViewController
    }
    
    func showDetailOf(book: Book) {
        guard let bookViewController = storyboard?.instantiateViewController(withIdentifier: BookViewController.storyboardId) as? BookViewController else {
            fatalError("BookViewController not found in Main.storyboard")
        }
        ServiceLocator.injectDependencies(to: bookViewController, using: book)
        show(bookViewController, sender: self)
    }
}